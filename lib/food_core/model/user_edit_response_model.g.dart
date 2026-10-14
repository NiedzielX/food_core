// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_edit_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEditResponseModel _$UserEditResponseModelFromJson(
    Map<String, dynamic> json) {
  return UserEditResponseModel(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UserEditResponseModelToJson(
        UserEditResponseModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'success': instance.success,
      'message': instance.message,
    };
