import 'package:food_core/food_core/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_product_response_model.g.dart';

@JsonSerializable()
class FavoriteProductResponseModel {

  @JsonKey(name:"favorites_products", defaultValue: [])
  List<Product> favoritesProducts;

  FavoriteProductResponseModel();

  factory FavoriteProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteProductResponseModelToJson(this);
}
