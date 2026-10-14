import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_answers_presenter.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_save_answer_button.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_type_head_text_form.dart';
import 'package:food_core/food_core/ui/interview/interview_stream_state.dart';
import 'package:food_core/food_core/ui/views/list_separator.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class InterviewSearchAnswerPage extends StatefulWidget {
  final InterviewQuestionModel _interviewModel;

  InterviewSearchAnswerPage(this._interviewModel);

  @override
  _InterviewSearchAnswerPageState createState() =>
      _InterviewSearchAnswerPageState();
}

class _InterviewSearchAnswerPageState extends State<InterviewSearchAnswerPage> {
  InterviewAnswerPresenter _answerPresenter;

  ValueSetter<InterviewAnswerModel> _suggestionListCallback;

  _InterviewSearchAnswerPageState() {
    _suggestionListCallback = (selectedAnswers) {
      setState(() {
        _answerPresenter.addAnswer(selectedAnswers);
      });
    };
  }

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
            _buildQuestion(context),
            _buildAnswersView(snapshot),
            SaveAnswerButton(_answerPresenter)
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

  Widget _buildAnswersView(AsyncSnapshot<InterviewStreamState> snapshot) {
    switch (snapshot.data) {
      case InterviewStreamState.COMPLETED:
        return _buildInterviewAnswers();
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

  Widget _buildInterviewAnswers() {
    var interviewAnswers = _answerPresenter.getInterviewAnswers();
    var selectedAnswers = _answerPresenter.getInterviewSelectedAnswers();
    final List<Widget> itemList = [];
    for (int i = 0; i < selectedAnswers.length; i++) {
      itemList.add(_getSelectedAnswers(selectedAnswers[i]));
    }

    itemList.add(Form(
      child:
          InterviewTypeHeadTextForm(interviewAnswers, _suggestionListCallback),
    ));
    return Expanded(
      child: ListView(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 50),
          children: itemList),
    );
  }

  selectAnswer(InterviewAnswerModel answer) {
    setState(() {
      _answerPresenter.addAnswer(answer);
    });
  }

  Widget _getSelectedAnswers(InterviewAnswerModel selectedAnswerModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedAnswerModel.answer,
          style: GlobalUtils.interviewBody1TextStyle(16),
        ),
        CustomDivider(height: 25)
      ],
    );
  }
}
