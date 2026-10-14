import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_answer_response_model.g.dart';

@JsonSerializable()
class InterviewAnswerResponseModel {
  @JsonKey(name: "answers", defaultValue: [])
  List<InterviewAnswerModel> interviewAnswers;

  InterviewAnswerResponseModel();

  factory InterviewAnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewAnswerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewAnswerResponseModelToJson(this);
}
