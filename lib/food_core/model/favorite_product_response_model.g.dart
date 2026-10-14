// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteProductResponseModel _$FavoriteProductResponseModelFromJson(
    Map<String, dynamic> json) {
  return FavoriteProductResponseModel()
    ..favoritesProducts = (json['favorites_products'] as List)
            ?.map((e) =>
                e == null ? null : Product.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$FavoriteProductResponseModelToJson(
        FavoriteProductResponseModel instance) =>
    <String, dynamic>{
      'favorites_products': instance.favoritesProducts,
    };
