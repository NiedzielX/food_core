// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_answer_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewAnswerResponseModel _$InterviewAnswerResponseModelFromJson(
    Map<String, dynamic> json) {
  return InterviewAnswerResponseModel()
    ..interviewAnswers = (json['answers'] as List)
            ?.map((e) => e == null
                ? null
                : InterviewAnswerModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$InterviewAnswerResponseModelToJson(
        InterviewAnswerResponseModel instance) =>
    <String, dynamic>{
      'answers': instance.interviewAnswers,
    };
