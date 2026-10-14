import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/interview_summary_model.dart';
import 'package:food_core/food_core/model/interview_summary_response_model.dart';
import 'package:food_core/food_core/repositories/interview_repository.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class InterviewSummaryMockAdapter extends MockAdapter {
  InterviewRepository interviewRepository;

  InterviewSummaryMockAdapter(this.interviewRepository);

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    List<String> messages = [
      "Spróbuj diety lowFodmaps",
      "Spróbuj diety niskohistaminowej",
      "Spróbuj diety niskohistaminowej, z ograniczeniem barwników i konserwantów",
      "Spróbuj diety bezglutenowej",
      "Spróbuj wyeliminować mleko, produkty z wysokim indeksem glikemicznym oraz dużą zawartością tłuszczu",
    ];

    var queryParameters = options.queryParameters;
    int questionId = queryParameters.values.first;
    String message = "";

    List<int> selectedAnswer = await interviewRepository.getSelectedAnswers(3);
    if (selectedAnswer.isNotEmpty) {
      var answer = selectedAnswer[0];
      switch (answer) {
        case 18:
          message = messages[0];
          break;
        case 19:
          message = messages[1];
          break;
        case 20:
          message = messages[2];
          break;
        case 21:
          message = messages[3];
          break;
        case 22:
          message = messages[4];
          break;
      }
    }

    var interviewSummaryModel = InterviewSummaryModel();
    interviewSummaryModel.message = message;
    interviewSummaryModel.description = "";

    interviewSummaryModel.isInterviewCompleted = true;

    var interviewSummaryResponseModel = InterviewSummaryResponseModel();
    interviewSummaryResponseModel.interviewSummaryModel = interviewSummaryModel;

    String response = jsonEncode(interviewSummaryResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}
