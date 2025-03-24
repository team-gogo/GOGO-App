import 'package:json_annotation/json_annotation.dart';

part 'search_point_response.g.dart';

@JsonSerializable()
class SearchPointResponse {
  final int point;

  SearchPointResponse({required this.point});

  factory SearchPointResponse.fromJson(Map<String, dynamic> json) => _$SearchPointResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPointResponseToJson(this);
}