import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:json_annotation/json_annotation.dart';

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

@JsonEnum(alwaysCreate: true)
enum GameType {
  @JsonValue("SOCCER")
  SOCCER,
  @JsonValue("BASKET_BALL")
  BASKET_BALL,
  @JsonValue("BASE_BALL")
  BASE_BALL,
  @JsonValue("VOLLEY_BALL")
  VOLLEY_BALL,
  @JsonValue("BADMINTON")
  BADMINTON,
  @JsonValue("LOL")
  LOL,
  @JsonValue("ETC")
  ETC,
}
