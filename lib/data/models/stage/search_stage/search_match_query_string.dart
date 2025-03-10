import 'package:json_annotation/json_annotation.dart';

part 'search_match_query_string.g.dart';

@JsonSerializable()
class SearchMatchQueryString {
  final String y; // 년
  final String m; // 월
  final String d; // 일

  SearchMatchQueryString({
    required this.y,
    required this.m,
    required this.d,
  });

  factory SearchMatchQueryString.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchQueryStringFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMatchQueryStringToJson(this);
}
