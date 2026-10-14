import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String title;
  @JsonKey(name: "moreSugar", defaultValue: false)
  bool moreSugar;
  @JsonKey(name: "image", defaultValue: "")
  String image;
  @JsonKey(name: "brand", defaultValue: "")
  String brand;
  @JsonKey(name: "quantity", defaultValue: 0)
  double quantity;
  @JsonKey(name: "unit", defaultValue: "")
  String unit;
  @JsonKey(name: "is_favorite", defaultValue: false)
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.moreSugar,
      this.image,
      this.brand,
      this.quantity,
      this.unit,
      this.isFavorite});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
