// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    title: json['title'] as String,
    moreSugar: json['moreSugar'] as bool ?? false,
    image: json['image'] as String ?? '',
    brand: json['brand'] as String ?? '',
    quantity: (json['quantity'] as num)?.toDouble() ?? 0,
    unit: json['unit'] as String ?? '',
    isFavorite: json['is_favorite'] as bool ?? false,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'moreSugar': instance.moreSugar,
      'image': instance.image,
      'brand': instance.brand,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'is_favorite': instance.isFavorite,
    };
