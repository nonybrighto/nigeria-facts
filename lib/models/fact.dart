import 'package:json_annotation/json_annotation.dart';
import 'package:dailyfactsng/models/serializers.dart';

part 'fact.g.dart';

@JsonSerializable()
class Fact{

  String id;
  String title;
  String summary;
  String description;
  String imageUrl;
  String categoryId;
  @JsonKey(defaultValue: false, fromJson: generateBoolFromInt, toJson: generateIntFromBool)
  bool isBookmarked;
  @JsonKey(defaultValue: false, fromJson: generateBoolFromInt, toJson: generateIntFromBool)
  bool isViewed;

  Fact({
    this.id,
    this.title,
    this.summary,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.isBookmarked,
    this.isViewed
  });

  factory Fact.fromJson(Map<String, dynamic> map) => _$FactFromJson(map);
  Map<String, dynamic> toJson() => _$FactToJson(this);
}