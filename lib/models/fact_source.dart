import 'package:json_annotation/json_annotation.dart';

part 'fact_source.g.dart';

@JsonSerializable()
class FactSource{

  int id;
  String factId;
  String title;
  String link;

  FactSource({
   this.id,
   this.factId,
   this.title,
   this.link
  });

  factory FactSource.fromJson(Map<String, dynamic> map) => _$FactSourceFromJson(map);
  Map<String, dynamic> toJson() => _$FactSourceToJson(this);
}