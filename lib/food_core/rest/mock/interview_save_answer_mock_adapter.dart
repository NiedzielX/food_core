import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/interview_save_answer_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class InterviewSaveAnswerMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var interviewSaveAnswerResponseModel = InterviewSaveAnswerResponseModel();
    interviewSaveAnswerResponseModel.success = true;

    String response = jsonEncode(interviewSaveAnswerResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
