import 'package:json_annotation/json_annotation.dart';

part 'user_delete_response_model.g.dart';

@JsonSerializable()
class UserDeleteResponseModel {
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;

  UserDeleteResponseModel({this.success, this.message});

  factory UserDeleteResponseModel.fromJson(Map<String, dynamic> json) => _$UserDeleteResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserDeleteResponseModelToJson(this);
}