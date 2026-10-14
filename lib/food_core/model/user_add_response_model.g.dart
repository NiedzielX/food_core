// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_add_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddResponseModel _$UserAddResponseModelFromJson(Map<String, dynamic> json) {
  return UserAddResponseModel(
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserAddResponseModelToJson(
        UserAddResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
