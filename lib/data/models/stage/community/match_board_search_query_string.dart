import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:json_annotation/json_annotation.dart';

import '../game_type.dart';

part 'match_board_search_query_string.g.dart';

@JsonSerializable()
class MatchBoardSearchQueryString {
  final int page;
  final int size;
  final GameType type;
  final SortType sort;

  MatchBoardSearchQueryString({
    required this.page,
    required this.size,
    required this.type,
    required this.sort,
  });

  factory MatchBoardSearchQueryString.fromJson(Map<String, dynamic> json) =>
      _$MatchBoardSearchQueryStringFromJson(json);
  Map<String, dynamic> toJson() => _$MatchBoardSearchQueryStringToJson(this);
}
