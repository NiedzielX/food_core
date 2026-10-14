import 'package:json_annotation/json_annotation.dart';

part 'interview_save_answer_response_model.g.dart';

@JsonSerializable()
class InterviewSaveAnswerResponseModel{

  bool success;

  InterviewSaveAnswerResponseModel();

  factory InterviewSaveAnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewSaveAnswerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewSaveAnswerResponseModelToJson(this);

}