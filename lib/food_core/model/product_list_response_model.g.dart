// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListResponseModel _$ProductListResponseModelFromJson(
    Map<String, dynamic> json) {
  return ProductListResponseModel()
    ..food = (json['food'] as List)
            ?.map((e) =>
                e == null ? null : Product.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..exclusive = (json['exclusive'] as List)
            ?.map((e) =>
                e == null ? null : Product.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..bestsell = (json['bestsell'] as List)
            ?.map((e) =>
                e == null ? null : Product.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$ProductListResponseModelToJson(
        ProductListResponseModel instance) =>
    <String, dynamic>{
      'food': instance.food,
      'exclusive': instance.exclusive,
      'bestsell': instance.bestsell,
    };
