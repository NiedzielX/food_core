import 'package:json_annotation/json_annotation.dart';

part 'suggestion_model.g.dart';

@JsonSerializable()
class SuggestionModel {

  String value;
  String brand;

  SuggestionModel({this.value, this.brand});

  factory SuggestionModel.fromJson(Map<String, dynamic> json) => _$SuggestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionModelToJson(this);
}