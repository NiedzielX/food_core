// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_summary_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewSummaryResponseModel _$InterviewSummaryResponseModelFromJson(
    Map<String, dynamic> json) {
  return InterviewSummaryResponseModel()
    ..interviewSummaryModel = json['summary'] == null
        ? null
        : InterviewSummaryModel.fromJson(
            json['summary'] as Map<String, dynamic>);
}

Map<String, dynamic> _$InterviewSummaryResponseModelToJson(
        InterviewSummaryResponseModel instance) =>
    <String, dynamic>{
      'summary': instance.interviewSummaryModel,
    };
