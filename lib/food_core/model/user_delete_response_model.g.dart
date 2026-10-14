// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_delete_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDeleteResponseModel _$UserDeleteResponseModelFromJson(
    Map<String, dynamic> json) {
  return UserDeleteResponseModel(
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserDeleteResponseModelToJson(
        UserDeleteResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
