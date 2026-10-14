import 'package:flutter/material.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_answers_presenter.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_save_answer_state.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_save_answer_view.dart';
import 'package:food_core/food_core/ui/interview/summary/interview_summary_component.dart';
import 'package:food_core/food_core/utils/message_dialog.dart';
import 'package:food_core/food_core/utils/strings.dart';

class SaveAnswerButton extends StatefulWidget {
  @override
  _SaveAnswerButtonState createState() => _SaveAnswerButtonState();

  final InterviewAnswerPresenter _answerPresenter;

  SaveAnswerButton(this._answerPresenter);
}

class _SaveAnswerButtonState extends State<SaveAnswerButton>
    implements InterviewSaveAnswerView {
  @override
  void initState() {
    super.initState();
    widget._answerPresenter.setInterviewSaveAnswerView(this);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: InterviewSaveAnswerState.IDLE,
      stream: widget._answerPresenter.getSaveInterviewAnswerStateStream(),
      builder: (context, snapshot) => _buildSaveAnswerButton(snapshot),
    );
  }

  Padding _buildSaveAnswerButton(
      AsyncSnapshot<InterviewSaveAnswerState> snapshot) {
    var isAnswerSaving = snapshot.data == InterviewSaveAnswerState.SAVING;
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: isAnswerSaving ? _getLoader() : _getButton());
  }

  Widget _getButton() =>
      AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: widget._answerPresenter.isSaveButtonEnabled() ? 1 : 0.3,
        child: ElevatedButton(
          onPressed: widget._answerPresenter.isSaveButtonEnabled()
              ? () {
            _saveAnswers();
          }
              : null,
          child: Text(
            Strings.interviewSave.toUpperCase(),
          ),
        ),
      );

  void _saveAnswers() {
    widget._answerPresenter.saveInterviewAnswers();
  }

  Widget _getLoader() =>
      Container(
        child: Center(child: CircularProgressIndicator()),
      );

  @override
  onError(String errorMessage) {
    showMessageDialog(context, errorMessage);
  }

  @override
  saveAnswerSuccess() {
    bool isCompleted = widget._answerPresenter
        .getInterviewSelectedAnswers()
        .length > 0;
    if (!isCompleted) {
      return;
    }
    var interviewQuestion = widget._answerPresenter.getInterviewQuestion();
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => InterviewSummaryPage(interviewQuestion)));
  }
}
