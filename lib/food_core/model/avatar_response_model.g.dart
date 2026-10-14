// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarResponseModel _$AvatarResponseModelFromJson(Map<String, dynamic> json) {
  return AvatarResponseModel(
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AvatarResponseModelToJson(
        AvatarResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
