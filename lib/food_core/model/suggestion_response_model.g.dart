// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionResponseModel _$SuggestionResponseModelFromJson(
    Map<String, dynamic> json) {
  return SuggestionResponseModel()
    ..items = (json['items'] as List)
            ?.map((e) => e == null
                ? null
                : SuggestionModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$SuggestionResponseModelToJson(
        SuggestionResponseModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
