import 'package:gogo_app/data/models/stage/create_stage/game.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_game_response.g.dart';

@JsonSerializable()
class SearchGameResponse {
  final int count;
  final List<SearchGameItem> games;

  const SearchGameResponse({
    required this.count,
    required this.games,
  });

  factory SearchGameResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchGameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchGameResponseToJson(this);
}

@JsonSerializable()
class SearchGameItem {
  final int gameId;
  final String gameName;
  final int teamCount;
  final int teamMinCapacity;
  final int teamMaxCapacity;
  final GameType category;
  final GameSystem system;

  SearchGameItem({
    required this.gameId,
    required this.gameName,
    required this.teamCount,
    required this.teamMinCapacity,
    required this.teamMaxCapacity,
    required this.category,
    required this.system,
  });

  factory SearchGameItem.fromJson(Map<String, dynamic> json) =>
      _$SearchGameItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchGameItemToJson(this);
}
