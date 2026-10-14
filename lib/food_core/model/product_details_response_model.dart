import 'package:food_core/food_core/model/product_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_response_model.g.dart';

@JsonSerializable()
class ProductDetailsResponseModel {
  @JsonKey(name: "product")
  ProductDetailsModel productDetailsModel;

  ProductDetailsResponseModel();

  factory ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) => _$ProductDetailsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsResponseModelToJson(this);
}
