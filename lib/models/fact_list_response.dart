import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/models/list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fact_list_response.g.dart';

@JsonSerializable()
class FactListResponse implements ListResponse<Fact>{
  
  int currentPage;
  int nextPage;
  int perPage;
  int previousPage;
  List<Fact> results;
  int totalPages;
 
  FactListResponse({this.currentPage, this.nextPage, this.perPage, this.previousPage, this.totalPages, this.results});

  factory FactListResponse.fromJson(Map<String, dynamic> map) => _$FactListResponseFromJson(map);
  Map<String, dynamic> toJson() => _$FactListResponseToJson(this);

}