import 'dart:async';

import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/repositories/interview_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_save_answer_state.dart';
import 'package:food_core/food_core/ui/interview/answers/interview_save_answer_view.dart';
import 'package:food_core/food_core/ui/interview/interview_stream_state.dart';

abstract class InterviewAnswerPresenter {
  setInterviewSaveAnswerView(InterviewSaveAnswerView interviewSaveAnswerView);

  Stream<InterviewSaveAnswerState> getSaveInterviewAnswerStateStream();

  Stream<InterviewStreamState> getInterviewAnswerStream();

  bool isAnswerSelected(InterviewAnswerModel answer);

  List<InterviewAnswerModel> getInterviewAnswers();

  List<InterviewAnswerModel> getInterviewSelectedAnswers();

  selectSingleAnswer(InterviewAnswerModel answer);

  InterviewAnswerModel getSingleSelectedAnswer();

  addAnswer(InterviewAnswerModel answer);

  Future<void> fetchInterviewAnswers();

  String getFetchAnswersErrorMessage();

  InterviewQuestionModel getInterviewQuestion();

  bool isSaveButtonEnabled();

  saveInterviewAnswers();

  dispose();
}

class BaseInterviewAnswersPresenter extends InterviewAnswerPresenter {
  final StreamController _saveAnswerStreamController =
      StreamController<InterviewSaveAnswerState>();

  final StreamController _answersStreamController =
      StreamController<InterviewStreamState>();

  final InterviewRepository _interviewRepository = InterviewRepository();

  final List<InterviewAnswerModel> _selectedInterviewAnswers = [];

  InterviewSaveAnswerView _interviewSaveAnswerView;

  List<InterviewAnswerModel> _interviewAnswers;

  InterviewQuestionModel _interviewQuestionModel;

  ErrorResponseModel _fetchAnswersErrorResponseModel;

  InterviewAnswerModel _selectedAnswer;

  bool _isDisposed = false;

  BaseInterviewAnswersPresenter(this._interviewQuestionModel);

  @override
  Stream<InterviewSaveAnswerState> getSaveInterviewAnswerStateStream() {
    return _saveAnswerStreamController.stream;
  }

  @override
  Stream<InterviewStreamState> getInterviewAnswerStream() {
    return _answersStreamController.stream;
  }

  @override
  fetchInterviewAnswers() async {
    try {
      _answersStreamController.add(InterviewStreamState.LOADING);
      var response = await _interviewRepository
          .fetchInterviewAnswers(_interviewQuestionModel.id);
      var interviewAnswers = response.interviewAnswers;
      this._interviewAnswers = interviewAnswers;

      List<int> selectedAnswers = await _interviewRepository
          .getSelectedAnswers(_interviewQuestionModel.id);


      //TODO multi select
      if (selectedAnswers != null && selectedAnswers.isNotEmpty) {
        int selectedAnswer = selectedAnswers[0];
        _interviewAnswers.forEach((model) {
          if(model.id == selectedAnswer){
            _selectedInterviewAnswers.add(model);
            _selectedAnswer = model;
          }
        });
      }

      if (_isDisposed) return;
      _answersStreamController.add(InterviewStreamState.COMPLETED);
    } catch (e) {
      handleFetchAnswersError(e);
    }
  }

  void handleFetchAnswersError(e) {
    if (_isDisposed) return;
    _fetchAnswersErrorResponseModel = ErrorHandler.of(e);
    _answersStreamController.add(InterviewStreamState.ERROR);
  }

  @override
  String getFetchAnswersErrorMessage() {
    var responseData = _fetchAnswersErrorResponseModel.responseData;
    var errorMessage;
    if (responseData != null) {
      errorMessage = ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      errorMessage = _fetchAnswersErrorResponseModel.errorMessage;
    }
    return errorMessage;
  }

  @override
  List<InterviewAnswerModel> getInterviewAnswers() {
    return _interviewAnswers;
  }

  @override
  selectSingleAnswer(InterviewAnswerModel answer) {
    _selectedInterviewAnswers.clear();
    if (_selectedAnswer == answer) {
      _selectedAnswer = null;
      return;
    }

    _selectedInterviewAnswers.add(answer);
    _selectedAnswer = answer;
  }

  @override
  addAnswer(InterviewAnswerModel answer) {
    if (_selectedInterviewAnswers.contains(answer)) {
      _selectedInterviewAnswers.remove(answer);
    } else {
      _selectedInterviewAnswers.add(answer);
    }
  }

  @override
  saveInterviewAnswers() async {
    try {
      _saveAnswerStreamController.add(InterviewSaveAnswerState.SAVING);

      var questionId = _interviewQuestionModel.id;
      var answers = await _mapAnswers();

      await _interviewRepository.saveInterviewAnswer(questionId, answers);
      _interviewSaveAnswerView.saveAnswerSuccess();

      if(_selectedInterviewAnswers.isEmpty){
        _saveAnswerStreamController.add(InterviewSaveAnswerState.IDLE);
      }

    } catch (e) {
      handleSaveAnswersError(e);
      _saveAnswerStreamController.add(InterviewSaveAnswerState.IDLE);
    }
  }

  Future<List<int>> _mapAnswers() async => _selectedInterviewAnswers
      .map((answer) => answer.id)
      .toList(growable: false);

  void handleSaveAnswersError(e) {
    if (_isDisposed) return;
    var errorResponseModel = ErrorHandler.of(e);
    var responseData = errorResponseModel.responseData;
    String errorMessage;
    if (responseData != null) {
      errorMessage = ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      errorMessage = errorResponseModel.errorMessage;
    }

    _interviewSaveAnswerView.onError(errorMessage);
  }

  @override
  bool isAnswerSelected(InterviewAnswerModel answer) {
    return _selectedInterviewAnswers.contains(answer);
  }

  @override
  bool isSaveButtonEnabled() {
    return true;
  }

  @override
  dispose() {
    _saveAnswerStreamController.close();
    _answersStreamController.close();
    _interviewRepository.dispose();
    _isDisposed = true;
  }

  @override
  setInterviewSaveAnswerView(InterviewSaveAnswerView interviewSaveAnswerView) {
    _interviewSaveAnswerView = interviewSaveAnswerView;
  }

  @override
  List<InterviewAnswerModel> getInterviewSelectedAnswers() {
    return _selectedInterviewAnswers;
  }

  @override
  InterviewAnswerModel getSingleSelectedAnswer() {
    return _selectedAnswer;
  }

  @override
  InterviewQuestionModel getInterviewQuestion() {
     return _interviewQuestionModel;
  }
}
