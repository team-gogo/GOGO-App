import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

enum GameSystem {
  @JsonValue("TOURNAMENT")
  TOURNAMENT,
  @JsonValue("FULL_LEAGUE")
  FULL_LEAGUE,
  @JsonValue("SINGLE")
  SINGLE,
  @JsonValue("NULL")
  NULL
}

@JsonSerializable()
class Game {
  final GameType category;
  final String name;
  final GameSystem system;
  final int teamMinCapacity;
  final int teamMaxCapacity;

  Game({
    required this.category,
    required this.name,
    required this.system,
    required this.teamMinCapacity,
    required this.teamMaxCapacity,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
