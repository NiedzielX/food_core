import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_answers_presenter.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_save_answer_button.dart';
import 'package:food_core/food_core/ui/interview/interview_stream_state.dart';
import 'package:food_core/food_core/ui/views/list_separator.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class InterviewSingleAnswerPage extends StatefulWidget {
  final InterviewQuestionModel _interviewModel;

  InterviewSingleAnswerPage(this._interviewModel);

  @override
  _InterviewSingleAnswerPageState createState() =>
      _InterviewSingleAnswerPageState();
}

class _InterviewSingleAnswerPageState extends State<InterviewSingleAnswerPage> {
  InterviewAnswerPresenter _answerPresenter;

  @override
  void initState() {
    super.initState();
    _answerPresenter = BaseInterviewAnswersPresenter(widget._interviewModel);
    _answerPresenter.fetchInterviewAnswers();
  }

  @override
  void dispose() {
    _answerPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: StreamBuilder<InterviewStreamState>(
        initialData: InterviewStreamState.LOADING,
        stream: _answerPresenter.getInterviewAnswerStream(),
        builder: (context, snapshot) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildQuestion(),
            _buildQuestionDescription(),
            _buildAnswersBody(snapshot),
            SaveAnswerButton(_answerPresenter)
          ],
        ),
      ),
    );
  }

  Padding _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Flexible(
            child: Text(widget._interviewModel.question,
                style: GlobalUtils.darkHeadingText(context, 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionDescription() {
    return Visibility(
      visible: widget._interviewModel.description != null ||
          widget._interviewModel.description.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, bottom: 15, right: 15),
        child: Row(
          children: [
            Flexible(
              child: Text(widget._interviewModel.description,
                  style: GlobalUtils.body1Text(context, 13)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(Constants.appBarSize),
      child: AppBar(
        centerTitle: true,
        title: Text(Strings.interviewPageTitle,
            style: GlobalUtils.pageTitleText(20)),
        leading: IconButton(
            icon: Assets.whiteBackArrow,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        brightness: Brightness.dark,
        backgroundColor: MyColors.skyBlue,
        elevation: 0,
      ),
    );
  }

  Widget _buildAnswersBody(AsyncSnapshot<InterviewStreamState> snapshot) {
    switch (snapshot.data) {
      case InterviewStreamState.COMPLETED:
        return _buildInterviewAnswerList();
      case InterviewStreamState.ERROR:
        return _buildInterviewAnswerErrorWidget();
      case InterviewStreamState.LOADING:
      default:
        return Expanded(child: Center(child: CircularProgressIndicator()));
    }
  }

  Widget _buildInterviewAnswerErrorWidget() {
    return Center(
        child: Text(
      _answerPresenter.getFetchAnswersErrorMessage(),
      style: GlobalUtils.body1Text(context),
    ));
  }

  Widget _buildInterviewAnswerList() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: _answerPresenter
            .getInterviewAnswers()
            .map((model) => _buildAnswerItem(model))
            .toList(),
      ),
    );
  }

  Widget _buildAnswerItem(InterviewAnswerModel model) {
    return InkWell(
      onTap: () => selectAnswer(model),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                model.answer,
                style: GlobalUtils.interviewBody1TextStyle(12),
              ),
            )),
            Radio(
              toggleable: true,
              value: model.answer,
              groupValue:
                  _answerPresenter.getSingleSelectedAnswer()?.answer ?? null,
              onChanged: (value) => selectAnswer(model),
            )
          ],
        ),
        CustomDivider(
          height: 1,
        )
      ]),
    );
  }

  selectAnswer(InterviewAnswerModel answer) {
    setState(() {
      _answerPresenter.selectSingleAnswer(answer);
    });
  }
}
