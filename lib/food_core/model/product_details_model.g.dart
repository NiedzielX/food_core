// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) {
  return ProductDetailsModel(
    id: json['id'] as int,
    title: json['title'] as String,
    brand: json['brand'] as String,
    image: json['image'] as String ?? '',
    description: json['description'] as String ?? '',
    ingredients: (json['ingredients'] as List)
            ?.map((e) => e == null
                ? null
                : ProductIngredient.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    weight: json['weight'] as String ?? '',
    nutritionalValues: (json['nutritionalValues'] as List)
            ?.map((e) => e == null
                ? null
                : ProductNutritionalValue.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    alternatives: (json['alternatives'] as List)
            ?.map((e) =>
                e == null ? null : Product.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    isFavorite: json['is_favorite'] as bool ?? false,
  );
}

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'brand': instance.brand,
      'image': instance.image,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'nutritionalValues': instance.nutritionalValues,
      'weight': instance.weight,
      'alternatives': instance.alternatives,
      'is_favorite': instance.isFavorite,
    };

ProductNutritionalValue _$ProductNutritionalValueFromJson(
    Map<String, dynamic> json) {
  return ProductNutritionalValue(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ProductNutritionalValueToJson(
        ProductNutritionalValue instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ProductIngredient _$ProductIngredientFromJson(Map<String, dynamic> json) {
  return ProductIngredient(
    name: json['name'] as String,
    info: json['info'] as String,
  );
}

Map<String, dynamic> _$ProductIngredientToJson(ProductIngredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'info': instance.info,
    };
