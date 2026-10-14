import 'package:food_core/food_core/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  static const String DEFAULT_VALUE = "";

  @JsonKey(nullable: false)
  int id;
  @JsonKey(nullable: false)
  String title;
  @JsonKey(nullable: false)
  String brand;
  @JsonKey(defaultValue: DEFAULT_VALUE)
  String image;
  @JsonKey(defaultValue: DEFAULT_VALUE)
  String description;
  @JsonKey(defaultValue: [])
  List<ProductIngredient> ingredients;
  @JsonKey(defaultValue: [])
  List<ProductNutritionalValue> nutritionalValues;
  @JsonKey(defaultValue: DEFAULT_VALUE)
  String weight;
  @JsonKey(defaultValue: [])
  List<Product> alternatives;
  @JsonKey(name: "is_favorite", defaultValue: false)
  bool isFavorite;

  ProductDetailsModel(
      {this.id,
      this.title,
      this.brand,
      this.image,
      this.description,
      this.ingredients,
      this.weight,
      this.nutritionalValues,
      this.alternatives,
      this.isFavorite});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable()
class ProductNutritionalValue {
  @JsonKey(nullable: false)
  String name;

  ProductNutritionalValue({this.name});

  factory ProductNutritionalValue.fromJson(Map<String, dynamic> json) =>
      _$ProductNutritionalValueFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductNutritionalValueToJson(this);
}

@JsonSerializable()
class ProductIngredient {
  @JsonKey(nullable: false)
  String name;
  String info;

  ProductIngredient({this.name, this.info});

  factory ProductIngredient.fromJson(Map<String, dynamic> json) =>
      _$ProductIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$ProductIngredientToJson(this);
}
