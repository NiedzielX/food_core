// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileListResponseModel _$UserProfileListResponseModelFromJson(
    Map<String, dynamic> json) {
  return UserProfileListResponseModel(
    profiles: (json['profiles'] as List)
            ?.map((e) =>
                e == null ? null : User.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$UserProfileListResponseModelToJson(
        UserProfileListResponseModel instance) =>
    <String, dynamic>{
      'profiles': instance.profiles,
    };
