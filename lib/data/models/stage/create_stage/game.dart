import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

enum GameSystem {
  @JsonValue("TOURNAMENT")
  TOURNAMENT,
  @JsonValue("FULL_LEAGUE")
  FULL_LEAGUE,
  @JsonValue("SINGLE")
  SINGLE,
}

@JsonSerializable()
class Game {
  final List<String> category;
  final String name;
  final String gameSystem;
  final int teamMinCapacity;
  final int teamMaxCapacity;

  Game({
    required this.category,
    required this.name,
    required this.gameSystem,
    required this.teamMinCapacity,
    required this.teamMaxCapacity,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
