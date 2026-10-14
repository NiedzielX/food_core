import 'package:food_core/food_core/model/interview_question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_question_response_model.g.dart';

@JsonSerializable()
class InterviewQuestionResponseModel {
  @JsonKey(name: "questions", defaultValue: [])
  List<InterviewQuestionModel> interviewQuestions;

  InterviewQuestionResponseModel();

  factory InterviewQuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewQuestionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewQuestionResponseModelToJson(this);
}
