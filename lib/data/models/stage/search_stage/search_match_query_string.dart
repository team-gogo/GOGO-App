import 'package:json_annotation/json_annotation.dart';

part 'search_match_query_string.g.dart';

@JsonSerializable()
class SearchMatchQueryString {
  final int y; // 년
  final int m; // 월
  final int d; // 일

  SearchMatchQueryString({
    required this.y,
    required this.m,
    required this.d,
  });

  factory SearchMatchQueryString.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchQueryStringFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMatchQueryStringToJson(this);
}
