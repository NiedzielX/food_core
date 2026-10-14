import 'dart:async';

import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/repositories/interview_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/interview/interview_stream_state.dart';

abstract class InterviewQuestionsPresenter {
  Stream<InterviewStreamState> getInterviewStream();

  Future<void> fetchInterviewQuestionData();

  List<InterviewQuestionModel> getInterviewQuestions();

  String getErrorMessage();

  onSkip();

  dispose();
}

class BaseInterviewQuestionPresenter extends InterviewQuestionsPresenter {
  StreamController<InterviewStreamState> _streamController =
      StreamController();

  InterviewRepository _interviewRepository = InterviewRepository();

  List<InterviewQuestionModel> _interviewQuestions;

  ErrorResponseModel _errorResponseModel;

  Local _local = Local();

  @override
  dispose() {
    _streamController.close();
  }

  @override
  Stream<InterviewStreamState> getInterviewStream() {
    return _streamController.stream;
  }

  @override
  fetchInterviewQuestionData() async {
    try {
      _streamController.add(InterviewStreamState.LOADING);
      var response = await _interviewRepository.fetchInterviewQuestions();
      var interviewQuestions = response.interviewQuestions;
      this._interviewQuestions = interviewQuestions;
      _streamController.add(InterviewStreamState.COMPLETED);
    } catch (e) {
      handleError(e);
    }
  }

  @override
  onSkip() {
    _local.setSkippedInterview(true);
  }

  void handleError(e) {
    if (_isDisposed()) return;
    _errorResponseModel = ErrorHandler.of(e);
    _streamController.add(InterviewStreamState.ERROR);
  }

  bool _isDisposed() => _streamController.isClosed;

  @override
  List<InterviewQuestionModel> getInterviewQuestions() {
    return this._interviewQuestions;
  }

  @override
  String getErrorMessage() {
    var responseData = _errorResponseModel.responseData;
    String errorMessage;
    if (responseData != null) {
      errorMessage = ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      errorMessage = _errorResponseModel.errorMessage;
    }
    return errorMessage;
  }
}
