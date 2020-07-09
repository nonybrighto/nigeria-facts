import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category{

  String id;
  String name;

  Category({
   this.id,
   this.name
  });

  factory Category.fromJson(Map<String, dynamic> map) => _$CategoryFromJson(map);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}