// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fact _$FactFromJson(Map<String, dynamic> json) {
  return Fact(
    id: json['id'] as String,
    title: json['title'] as String,
    summary: json['summary'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    categoryId: json['categoryId'] as int,
    isBookmarked: generateBoolFromInt(json['isBookmarked'] as int) ?? false,
    isViewed: generateBoolFromInt(json['isViewed'] as int) ?? false,
  );
}

Map<String, dynamic> _$FactToJson(Fact instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'categoryId': instance.categoryId,
      'isBookmarked': generateIntFromBool(instance.isBookmarked),
      'isViewed': generateIntFromBool(instance.isViewed),
    };
