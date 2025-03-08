import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

enum GameCategory {
  SOCCER,
  BASKET_BALL,
  BASE_BALL,
  VOLLEY_BALL,
  BADMINTON,
  LOL,
  ETC,
}

enum GameSystem {
  TOURNAMENT,
  FULL_LEAGUE,
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
