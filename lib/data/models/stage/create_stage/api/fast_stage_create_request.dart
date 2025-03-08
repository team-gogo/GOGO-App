import 'package:gogo_app/data/models/stage/create_stage/rule.dart';
import 'package:json_annotation/json_annotation.dart';

import '../game.dart';
import '../mini_game.dart';

part 'fast_stage_create_request.g.dart';

@JsonSerializable()
class FastStageCreateRequest {
  final String stageName;
  final Game game;
  final int initialPoint;
  final Rule rule;
  final MiniGame miniGame;
  final String? passCode;
  final List<int> maintainer;

  FastStageCreateRequest({
    required this.stageName,
    required this.game,
    required this.initialPoint,
    required this.rule,
    required this.miniGame,
    this.passCode,
    required this.maintainer,
  });

  factory FastStageCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$FastStageCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FastStageCreateRequestToJson(this);
}
