import 'package:json_annotation/json_annotation.dart';

part 'scan_response_model.g.dart';

@JsonSerializable()
class ScanResponseModel {

  @JsonKey(name: "id", defaultValue: 0)
  int id;

  ScanResponseModel();

  factory ScanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScanResponseModelToJson(this);
}