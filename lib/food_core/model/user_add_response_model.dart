import 'package:json_annotation/json_annotation.dart';

part 'user_add_response_model.g.dart';

@JsonSerializable()
class UserAddResponseModel {
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;

  UserAddResponseModel({this.success, this.message});

  factory UserAddResponseModel.fromJson(Map<String, dynamic> json) => _$UserAddResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserAddResponseModelToJson(this);
}