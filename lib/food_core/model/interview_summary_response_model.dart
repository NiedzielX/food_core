import 'package:food_core/food_core/model/interview_summary_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_summary_response_model.g.dart';

@JsonSerializable()
class InterviewSummaryResponseModel {

  @JsonKey(name: "summary")
  InterviewSummaryModel interviewSummaryModel;

  InterviewSummaryResponseModel();

  factory InterviewSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewSummaryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewSummaryResponseModelToJson(this);
}
