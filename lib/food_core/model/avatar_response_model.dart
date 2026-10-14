import 'package:json_annotation/json_annotation.dart';

part 'avatar_response_model.g.dart';

@JsonSerializable()
class AvatarResponseModel {
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;

  AvatarResponseModel({this.success, this.message});

  factory AvatarResponseModel.fromJson(Map<String, dynamic> json) => _$AvatarResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarResponseModelToJson(this);
}