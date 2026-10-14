import 'package:json_annotation/json_annotation.dart';

part 'interview_answer_model.g.dart';

@JsonSerializable()
class InterviewAnswerModel {
  @JsonKey(nullable: false)
  int id;
  @JsonKey(defaultValue: "")
  String answer;

  InterviewAnswerModel({this.id, this.answer});

  factory InterviewAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewAnswerModelToJson(this);
}
