import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_component.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_multi_answer_component.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_search_answer_component.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_single_answer_component.dart';
import 'package:food_core/food_core/ui/interview/interview_stream_state.dart';
import 'package:food_core/food_core/ui/interview/questions/interview_questions_presenter.dart';
import 'package:food_core/food_core/ui/views/custom_appbar/simple_appbar.dart';
import 'package:food_core/food_core/ui/views/list_separator.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class InterviewPage extends StatefulWidget {
  final InterviewParameters interviewParameters;

  static bool allowSkipInterview = false;

  InterviewPage({this.interviewParameters}) {
    allowSkipInterview = interviewParameters?.allowSkip ?? false;
  }

  @override
  InterviewPageState createState() => InterviewPageState();
}

class InterviewPageState extends State<InterviewPage> {
  InterviewQuestionsPresenter _iQuestionsPresenter =
      BaseInterviewQuestionPresenter();

  final double contentPadding = 15;

  @override
  void initState() {
    super.initState();
    _fetchInterviewQuestions();
  }

  @override
  void dispose() {
    _iQuestionsPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildStreamWidget(),
    );
  }

  StreamBuilder<InterviewStreamState> _buildStreamWidget() {
    return StreamBuilder<InterviewStreamState>(
      initialData: InterviewStreamState.LOADING,
      stream: _iQuestionsPresenter.getInterviewStream(),
      builder: (context, snapshot) => _buildInterview(snapshot),
    );
  }

  Widget _buildAppBar() {
    return SimpleAppBarWidget(AppbarParameters(
        title: Strings.interviewPageTitle,
        onBack: !InterviewPage.allowSkipInterview));
  }

  Widget _buildInterview(AsyncSnapshot<InterviewStreamState> snapshot) {
    Widget widget;
    switch (snapshot.data) {
      case InterviewStreamState.COMPLETED:
        widget = _buildInterviewQuestionList();
        break;
      case InterviewStreamState.ERROR:
        widget = _buildInterviewQuestionErrorWidget();
        break;
      case InterviewStreamState.LOADING:
      default:
        widget = Center(child: CircularProgressIndicator());
        break;
    }
    return widget;
  }

  Widget _buildInterviewQuestionList() {
    var interviewQuestions = _iQuestionsPresenter.getInterviewQuestions();
    return Column(children: [
      _buildSkipButton(),
      ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(contentPadding),
        children: interviewQuestions
            .map((model) => _buildQuestionItem(model))
            .toList(),
      )
    ]);
  }

  Widget _buildQuestionItem(InterviewQuestionModel model) {
    return InkWell(
      onTap: () => selectQuestion(model),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.question,
                    style: GlobalUtils.headingText(context, 14),
                  ),
                  Wrap(children: [
                    for (int i = 0; i < model.answerList.length; i++)
                      _buildAnswer(model.answerList, i)
                  ])
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Assets.arrow,
            )
          ],
        ),
        CustomDivider(
          height: 1,
        )
      ]),
    );
  }

  selectQuestion(InterviewQuestionModel model) {
    StatefulWidget destPage;
    switch (model.interviewAnswerType) {
      case InterviewAnswerType.SINGLE_ANSWER:
        destPage = InterviewSingleAnswerPage(model);
        break;
      case InterviewAnswerType.MULTI_ANSWER:
        destPage = InterviewMultiAnswerPage(model);
        break;
      case InterviewAnswerType.SEARCH_ANSWER:
        destPage = InterviewSearchAnswerPage(model);
        break;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => destPage))
        .whenComplete(() => _fetchInterviewQuestions());
  }

  Widget _buildInterviewQuestionErrorWidget() {
    return Center(
        child: Text(
      _iQuestionsPresenter.getErrorMessage(),
      style: GlobalUtils.body1Text(context),
    ));
  }

  Widget _buildSkipButton() {
    return Visibility(
        visible: widget?.interviewParameters?.allowSkip ?? false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                  style: GlobalUtils.textButtonStyle(),
                  onPressed: () => _skipInterviewPressed(),
                  child: Text(
                    Strings.interviewSkip,
                  )),
            )
          ],
        ));
  }

  _skipInterviewPressed() {
    _iQuestionsPresenter.onSkip();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardPage(), fullscreenDialog: true));
  }

  Widget _buildAnswer(List<InterviewAnswerModel> list, int position) {
    var answerModel = list[position];
    bool isLast = list.length - 1 == position;
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Text(
        "${answerModel.answer}${isLast ? "" : ","}",
        style: GlobalUtils.interviewBody1TextStyle(12),
      ),
    );
  }

  void _fetchInterviewQuestions() {
    _iQuestionsPresenter.fetchInterviewQuestionData();
  }
}

class InterviewParameters {
  final bool allowSkip;

  InterviewParameters({this.allowSkip = false});
}
