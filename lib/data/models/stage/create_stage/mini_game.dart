import 'package:json_annotation/json_annotation.dart';

part 'mini_game.g.dart';

@JsonSerializable()
class MiniGame {
  final bool isActive;
  final int? maxBettingPoint;

  MiniGame({required this.isActive, this.maxBettingPoint});

  factory MiniGame.fromJson(Map<String, dynamic> json) =>
      _$MiniGameFromJson(json);

  Map<String, dynamic> toJson() => _$MiniGameToJson(this);
}
