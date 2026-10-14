import 'package:food_core/food_core/model/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response_model.g.dart';

@JsonSerializable()
class CategoryResponseModel {
  @JsonKey(name: "categories", defaultValue: [])
  List<CategoryModel> categoryList;

  CategoryResponseModel();

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
}
