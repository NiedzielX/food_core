import 'package:json_annotation/json_annotation.dart';

part 'interview_summary_model.g.dart';

@JsonSerializable()
class InterviewSummaryModel {
  @JsonKey(defaultValue: "")
  String message;
  @JsonKey(defaultValue: "")
  String description;
  @JsonKey(defaultValue: false)
  @JsonKey(name: "interview_completed")
  bool isInterviewCompleted;

  InterviewSummaryModel();

  factory InterviewSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewSummaryModelToJson(this);
}
