// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewAnswerModel _$InterviewAnswerModelFromJson(Map<String, dynamic> json) {
  return InterviewAnswerModel(
    id: json['id'] as int,
    answer: json['answer'] as String ?? '',
  );
}

Map<String, dynamic> _$InterviewAnswerModelToJson(
        InterviewAnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
    };
