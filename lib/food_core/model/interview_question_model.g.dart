// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterviewQuestionModel _$InterviewQuestionModelFromJson(
    Map<String, dynamic> json) {
  return InterviewQuestionModel(
    id: json['id'] as int,
    interviewAnswerType: _$enumDecodeNullable(
        _$InterviewAnswerTypeEnumMap, json['interviewAnswerType']),
    question: json['question'] as String,
    answerList: (json['answers'] as List)
            ?.map((e) => e == null
                ? null
                : InterviewAnswerModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    description: json['description'] as String ?? '',
  );
}

Map<String, dynamic> _$InterviewQuestionModelToJson(
        InterviewQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'interviewAnswerType':
          _$InterviewAnswerTypeEnumMap[instance.interviewAnswerType],
      'question': instance.question,
      'answers': instance.answerList,
      'description': instance.description,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$InterviewAnswerTypeEnumMap = {
  InterviewAnswerType.SINGLE_ANSWER: 'single_answer',
  InterviewAnswerType.SEARCH_ANSWER: 'search_answer',
  InterviewAnswerType.MULTI_ANSWER: 'multi_answer',
};
