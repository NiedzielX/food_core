import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:food_core/food_core/model/interview_question_response_model.dart';
import 'package:food_core/food_core/repositories/interview_repository.dart';
import 'package:food_core/food_core/rest/mock/interview_answer_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class InterviewQuestionsMockAdapter extends MockAdapter {
  InterviewRepository interviewRepository;

  InterviewQuestionsMockAdapter(this.interviewRepository);

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var questions = [
      InterviewQuestionModel(
          id: 1,
          interviewAnswerType: InterviewAnswerType.SINGLE_ANSWER,
          question: "Czy stosujesz jakąś dietę?",
          answerList: await _getAnswers(1)),
      InterviewQuestionModel(
          id: 2,
          interviewAnswerType: InterviewAnswerType.SEARCH_ANSWER,
          question: "Jakich składników unikasz?",
          answerList: await _getAnswers(2)),
      InterviewQuestionModel(
          id: 3,
          interviewAnswerType: InterviewAnswerType.SINGLE_ANSWER,
          question: "Jakie masz objawy alergii?",
          answerList: await _getAnswers(3),
          description:
              "Wybierz jedną z poniższych sekcji jeśli odpowiedź na jedno z pytań jest twierdząca"),
    ];

    var interviewQuestionResponseModel = InterviewQuestionResponseModel();
    interviewQuestionResponseModel.interviewQuestions = questions;

    String response = jsonEncode(interviewQuestionResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }

  Future<List<InterviewAnswerModel>> _getAnswers(int id) async {
    List<int> selectedAnswers =
        await interviewRepository.getSelectedAnswers(id);
    List<InterviewAnswerModel> availableAnswers =
        InterviewAnswerMockAdapter.getInterviewAnswers(id);
    var list = availableAnswers
        .where((answer) => selectedAnswers.contains(answer.id))
        .toList();
    return list;
  }
}
