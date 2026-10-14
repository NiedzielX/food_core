import 'package:food_core/food_core/model/suggestion_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suggestion_response_model.g.dart';

@JsonSerializable()
class SuggestionResponseModel {
  @JsonKey(name: "items", defaultValue: [])
  List<SuggestionModel> items;

  SuggestionResponseModel();

  factory SuggestionResponseModel.fromJson(Map<String, dynamic> json) => _$SuggestionResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionResponseModelToJson(this);
}