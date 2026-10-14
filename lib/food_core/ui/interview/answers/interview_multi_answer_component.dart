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

class InterviewMultiAnswerPage extends StatefulWidget {
  final InterviewQuestionModel _interviewModel;

  InterviewMultiAnswerPage(this._interviewModel);

  @override
  _InterviewMultiAnswerPageState createState() =>
      _InterviewMultiAnswerPageState();
}

class _InterviewMultiAnswerPageState extends State<InterviewMultiAnswerPage> {
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
            _buildQuestion(context),
            _buildAnswerBody(snapshot),
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

  Widget _buildAnswerBody(AsyncSnapshot<InterviewStreamState> snapshot) {
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: _answerPresenter
            .getInterviewAnswers()
            .map((model) => _buildAnswerItem(model))
            .toList(),
      ),
    );
  }

  Widget _buildAnswerItem(InterviewAnswerModel answer) {
    bool isChecked = _answerPresenter.isAnswerSelected(answer);
    return InkWell(
      onTap: () => selectAnswer(answer),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                answer.answer,
                style: GlobalUtils.interviewBody1TextStyle(12),
              ),
            )),
            Checkbox(
              value: isChecked,
              onChanged: (value) => selectAnswer(answer),
            )
          ],
        ),
        CustomDivider(
          height: 1,
        )
      ]),
    );
  }

  selectAnswer(InterviewAnswerModel answerModel) {
    setState(() {
      _answerPresenter.addAnswer(answerModel);
    });
  }
}
