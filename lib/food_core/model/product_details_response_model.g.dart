// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponseModel _$ProductDetailsResponseModelFromJson(
    Map<String, dynamic> json) {
  return ProductDetailsResponseModel()
    ..productDetailsModel = json['product'] == null
        ? null
        : ProductDetailsModel.fromJson(json['product'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProductDetailsResponseModelToJson(
        ProductDetailsResponseModel instance) =>
    <String, dynamic>{
      'product': instance.productDetailsModel,
    };
