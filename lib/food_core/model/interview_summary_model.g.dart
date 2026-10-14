// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewSummaryModel _$InterviewSummaryModelFromJson(
    Map<String, dynamic> json) {
  return InterviewSummaryModel()
    ..message = json['message'] as String ?? ''
    ..description = json['description'] as String ?? ''
    ..isInterviewCompleted = json['isInterviewCompleted'] as bool ?? false;
}

Map<String, dynamic> _$InterviewSummaryModelToJson(
        InterviewSummaryModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'description': instance.description,
      'isInterviewCompleted': instance.isInterviewCompleted,
    };
