import 'package:food_core/food_core/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_list_response_model.g.dart';

@JsonSerializable()
class UserProfileListResponseModel {
  @JsonKey(name: "profiles", defaultValue: [])
  List<User> profiles;

  UserProfileListResponseModel({this.profiles});

  factory UserProfileListResponseModel.fromJson(Map<String, dynamic> json) => _$UserProfileListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileListResponseModelToJson(this);
}