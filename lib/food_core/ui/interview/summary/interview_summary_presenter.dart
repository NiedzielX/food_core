import 'dart:async';

import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/model/error_response_model.dart';
import 'package:food_core/food_core/model/interview_summary_model.dart';
import 'package:food_core/food_core/repositories/interview_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/interview/summary/interview_summary_state.dart';

abstract class InterviewSummaryPresenter {
  Stream<InterviewSummaryState> getInterviewSummaryStream();

  InterviewSummaryModel getInterviewSummary();

  Future<void> fetchInterviewSummary(int questionId);

  String getSummaryErrorMessage();

  dispose();
}

class BaseInterviewSummaryPresenter extends InterviewSummaryPresenter {
  final StreamController _iSummaryStreamController =
      StreamController<InterviewSummaryState>();

  final InterviewRepository _interviewRepository = InterviewRepository();

  ErrorResponseModel _iSummaryErrorResponseModel;

  InterviewSummaryModel _interviewSummaryModel;

  bool _isDisposed = false;

  @override
  dispose() {
    _iSummaryStreamController.close();
    _interviewRepository.dispose();
    _isDisposed = true;
  }

  @override
  Stream<InterviewSummaryState> getInterviewSummaryStream() {
    return _iSummaryStreamController.stream;
  }

  @override
  fetchInterviewSummary(int questionId) async {
    try {
      _iSummaryStreamController.add(InterviewSummaryState.LOADING);
      var response =
          await _interviewRepository.fetchInterviewSummary(questionId);
      this._interviewSummaryModel = response.interviewSummaryModel;
      _iSummaryStreamController.add(InterviewSummaryState.COMPLETED);
    } catch (e) {
      handleSummaryError(e);
    }
  }

  @override
  InterviewSummaryModel getInterviewSummary() {
    return _interviewSummaryModel;
  }

  void handleSummaryError(e) {
    if (_isDisposed) return;
    _iSummaryErrorResponseModel = ErrorHandler.of(e);
    _iSummaryStreamController.add(InterviewSummaryState.ERROR);
  }

  @override
  String getSummaryErrorMessage() {
    var responseData = _iSummaryErrorResponseModel.responseData;
    var errorMessage;
    if (responseData != null) {
      errorMessage = ErrorResponseDataModel.fromJson(responseData).message;
    } else {
      errorMessage = _iSummaryErrorResponseModel.errorMessage;
    }
    return errorMessage;
  }
}
