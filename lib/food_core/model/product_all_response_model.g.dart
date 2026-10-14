// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_all_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsAllResponseModel _$ProductsAllResponseModelFromJson(
    Map<String, dynamic> json) {
  return ProductsAllResponseModel()
    ..products = (json['products'] as List)
            ?.map((e) =>
                e == null ? null : Product.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$ProductsAllResponseModelToJson(
        ProductsAllResponseModel instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
