import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:json_annotation/json_annotation.dart';

import '../game_type.dart';

part 'community_search_request_query_string.g.dart';

@JsonSerializable()
class CommunitySearchRequestQueryString {
  final int page;
  final int size;
  final GameType type;
  final SortType sort;

  CommunitySearchRequestQueryString({
    required this.page,
    required this.size,
    required this.type,
    required this.sort,
  });

  factory CommunitySearchRequestQueryString.fromJson(
          Map<String, dynamic> json) =>
      _$CommunitySearchRequestQueryStringFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CommunitySearchRequestQueryStringToJson(this);
}
