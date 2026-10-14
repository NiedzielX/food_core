import 'package:json_annotation/json_annotation.dart';

part 'error_response_data_model.g.dart';

@JsonSerializable()
class ErrorResponseDataModel {
  @JsonKey(name: "message")
  String message;

  ErrorResponseDataModel({this.message});

  factory ErrorResponseDataModel.fromJson(
          Map<String, dynamic> json) =>
      _$ErrorResponseDataModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ErrorResponseDataModelToJson(this);
}
