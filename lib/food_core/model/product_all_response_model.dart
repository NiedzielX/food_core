import 'package:food_core/food_core/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_all_response_model.g.dart';

@JsonSerializable()
class ProductsAllResponseModel {
  @JsonKey(name: "products", defaultValue: [])
  List<Product> products;

  ProductsAllResponseModel();

  factory ProductsAllResponseModel.fromJson(Map<String, dynamic> json) => _$ProductsAllResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsAllResponseModelToJson(this);
}