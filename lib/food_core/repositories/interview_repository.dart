import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/interview_answer_response_model.dart';
import 'package:food_core/food_core/model/interview_question_response_model.dart';
import 'package:food_core/food_core/model/interview_save_answer_response_model.dart';
import 'package:food_core/food_core/model/interview_summary_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/interview_answer_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/interview_question_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/interview_save_answer_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/interview_summary_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterviewRepository {
  final CancelToken _iQuestionsCancelToken = CancelToken();
  final CancelToken _iSummaryCancelToken = CancelToken();
  final CancelToken _iAnswersCancelToken = CancelToken();
  final CancelToken _iSaveCancelToken = CancelToken();

  static const String INTERVIEW_SUMMARY = "interview_summary";

  Future<void> _submitInterviewQuestion(
      int questionId, List<int> answers) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(
        "$INTERVIEW_SUMMARY$questionId", answers.map((id) => "$id").toList());
  }

  Future<List<int>> getSelectedAnswers(int questionId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var stringIdList =
        sharedPreferences.getStringList("$INTERVIEW_SUMMARY$questionId") ?? [];
    List<int> list = stringIdList.map((id) => int.parse(id)).toList();
    return list;
  }

  Future<InterviewQuestionResponseModel> fetchInterviewQuestions() async {
    var mockAdapter = InterviewQuestionsMockAdapter(this);
    Dio dio = await DioProvider.get(mockAdapter: mockAdapter);
    return RestClient(dio).fetchInterviewQuestions(_iQuestionsCancelToken);
  }

  Future<InterviewAnswerResponseModel> fetchInterviewAnswers(int questionId,
      {String searchValue = ""}) async {
    var mockAdapter = InterviewAnswerMockAdapter();
    Dio dio = await DioProvider.get(mockAdapter: mockAdapter);
    return RestClient(dio)
        .fetchInterviewAnswers(_iAnswersCancelToken, questionId, searchValue);
  }

  Future<InterviewSaveAnswerResponseModel> saveInterviewAnswer(
      int questionId, List<int> answers) async {
    var mockAdapter = InterviewSaveAnswerMockAdapter();
    Dio dio = await DioProvider.get(mockAdapter: mockAdapter);
    var responseModel = await RestClient(dio)
        .saveInterviewAnswer(_iSaveCancelToken, questionId, answers);
    await _submitInterviewQuestion(questionId, answers);
    return responseModel;
  }

  Future<InterviewSummaryResponseModel> fetchInterviewSummary(
      int questionId) async {
    var mockAdapter = InterviewSummaryMockAdapter(this);
    Dio dio = await DioProvider.get(mockAdapter: mockAdapter);
    return RestClient(dio)
        .fetchInterviewSummary(_iSummaryCancelToken, questionId);
  }

  dispose() {
    _iQuestionsCancelToken.cancel();
    _iSummaryCancelToken.cancel();
    _iAnswersCancelToken.cancel();
    _iSaveCancelToken.cancel();
  }
}
