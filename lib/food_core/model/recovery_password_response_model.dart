import 'package:json_annotation/json_annotation.dart';

part 'recovery_password_response_model.g.dart';

@JsonSerializable()
class RecoveryPasswordResponseModel {
  @JsonKey(name: "message")
  String message;

  RecoveryPasswordResponseModel({this.message});

  factory RecoveryPasswordResponseModel.fromJson(Map<String, dynamic> json) => _$RecoveryPasswordResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecoveryPasswordResponseModelToJson(this);
}
