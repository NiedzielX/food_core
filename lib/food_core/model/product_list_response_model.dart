import 'package:food_core/food_core/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_response_model.g.dart';

@JsonSerializable()
class ProductListResponseModel {
  @JsonKey(name: "food", defaultValue: [])
  List<Product> food;
  @JsonKey(name: "exclusive", defaultValue: [])
  List<Product> exclusive;
  @JsonKey(name: "bestsell", defaultValue: [])
  List<Product> bestsell;

  ProductListResponseModel();

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) => _$ProductListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductListResponseModelToJson(this);
}