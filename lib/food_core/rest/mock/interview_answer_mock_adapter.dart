import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:food_core/food_core/model/interview_answer_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class InterviewAnswerMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));

    var interviewAnswerResponseModel = InterviewAnswerResponseModel();
    var path = options.path;
    var questionId = int.parse(path.substring(path.length - 1));

    interviewAnswerResponseModel.interviewAnswers =
        getInterviewAnswers(questionId);

    String response = jsonEncode(interviewAnswerResponseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }

  static List<InterviewAnswerModel> getInterviewAnswers(int questionId) {
    switch (questionId) {
      case 1:
        return [
          InterviewAnswerModel(id: 1, answer: "Dieta LowFodmaps"),
          InterviewAnswerModel(id: 2, answer: "Dieta Niskohistaminowa"),
          InterviewAnswerModel(id: 3, answer: "Dieta bezglutenowa"),
          InterviewAnswerModel(id: 4, answer: "Dieta przy trądziku")
        ];
      case 2:
        return [
          InterviewAnswerModel(id: 6, answer: "Pieprz"),
        ];
      case 3:
        return [
          InterviewAnswerModel(id: 18, answer: "    Czy odczuwasz wzdęcie brzucha, zaburzenia rytmu wypróżnień (biegunka/zaparcie)?\n    Czy po konkretnych produktach np. mleku/produktach mlecznych - czy produkty bezlaktozowe są dobrze tolerowane?\n    Czy bezlaktozowe nadal wywołują dolegliwości - wówczas eliminacja mleka krowiego/produktów mlecznych - zmiana na mleka roślinne (sojowe, owsiane, migdałowe, ryżowe)"),
          InterviewAnswerModel(id: 19, answer: "    Czy masz któryś z objawów-  biegunkę, pokrzywkę, świąd skóry, migrenowe bóle głowy, kołatania serca?"),
          InterviewAnswerModel(id: 20, answer: "    Czy masz nadwrażliwość na niesteroidowe leki przeciwzapalne, np kwas acetylosalicylowy, ibuprofen, czy dodatkowo chorujesz na astmę oskrzelową i polipy w nosie?"),
          InterviewAnswerModel(id: 21, answer: "    Czy chorujesz na celiakię, nadwrażliwość na gluten, chorobę Duhringa?"),
          InterviewAnswerModel(id: 22, answer: "Cierpisz na trądzik?")
        ];
      default:
        return [];
    }
  }
}
