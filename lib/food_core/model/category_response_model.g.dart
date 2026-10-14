// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponseModel _$CategoryResponseModelFromJson(
    Map<String, dynamic> json) {
  return CategoryResponseModel()
    ..categoryList = (json['categories'] as List)
            ?.map((e) => e == null
                ? null
                : CategoryModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$CategoryResponseModelToJson(
        CategoryResponseModel instance) =>
    <String, dynamic>{
      'categories': instance.categoryList,
    };
