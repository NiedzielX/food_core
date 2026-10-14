// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_question_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewQuestionResponseModel _$InterviewQuestionResponseModelFromJson(
    Map<String, dynamic> json) {
  return InterviewQuestionResponseModel()
    ..interviewQuestions = (json['questions'] as List)
            ?.map((e) => e == null
                ? null
                : InterviewQuestionModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$InterviewQuestionResponseModelToJson(
        InterviewQuestionResponseModel instance) =>
    <String, dynamic>{
      'questions': instance.interviewQuestions,
    };
