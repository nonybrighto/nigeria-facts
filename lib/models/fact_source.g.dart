// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FactSource _$FactSourceFromJson(Map<String, dynamic> json) {
  return FactSource(
    id: json['id'] as int,
    factId: json['factId'] as String,
    title: json['title'] as String,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$FactSourceToJson(FactSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'factId': instance.factId,
      'title': instance.title,
      'link': instance.link,
    };
