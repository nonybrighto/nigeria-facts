// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FactListResponse _$FactListResponseFromJson(Map<String, dynamic> json) {
  return FactListResponse(
    currentPage: json['currentPage'] as int,
    nextPage: json['nextPage'] as int,
    perPage: json['perPage'] as int,
    previousPage: json['previousPage'] as int,
    totalPages: json['totalPages'] as int,
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Fact.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FactListResponseToJson(FactListResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'nextPage': instance.nextPage,
      'perPage': instance.perPage,
      'previousPage': instance.previousPage,
      'results': instance.results,
      'totalPages': instance.totalPages,
    };
