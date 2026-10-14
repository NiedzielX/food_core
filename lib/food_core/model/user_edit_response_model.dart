import 'package:food_core/food_core/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_edit_response_model.g.dart';

@JsonSerializable()
class UserEditResponseModel {
  @JsonKey(name: "user", nullable: true)
  User user;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;

  UserEditResponseModel({this.user, this.success, this.message});

  factory UserEditResponseModel.fromJson(Map<String, dynamic> json) => _$UserEditResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserEditResponseModelToJson(this);
}