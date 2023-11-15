import 'package:json_annotation/json_annotation.dart';
import 'package:yakmoya/pill/pill_picture/model/search_response_model.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  List<SearchResponseModel> results;

  SearchResponse({required this.results});

  factory SearchResponse.fromJson(Map<String, dynamic> json)
  => _$SearchResponseFromJson(json);

  List<Map<String, dynamic>> toJson() => results.map((model) => model.toJson()).toList();
}
