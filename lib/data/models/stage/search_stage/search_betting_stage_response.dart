import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/data/models/stage/match_round.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_betting_stage_response.g.dart';

enum System {
  TOURNAMENT,
  FULL_LEAGUE,
  SINGLE,
}

@JsonSerializable()
class Team {
  final int teamId;
  final String teamName;
  final int bettingPoint;
  final int winCount;

  Team({
    required this.teamId,
    required this.teamName,
    required this.bettingPoint,
    required this.winCount,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class Betting {
  final bool isBetting;
  final int? bettingPoint;
  final int? predictedWinTeamId;

  Betting({
    required this.isBetting,
    this.bettingPoint,
    this.predictedWinTeamId,
  });

  factory Betting.fromJson(Map<String, dynamic> json) =>
      _$BettingFromJson(json);

  Map<String, dynamic> toJson() => _$BettingToJson(this);
}

@JsonSerializable()
class SearchBettingStageResponse {
  final int count;
  final List<MatchDto> matches;

  SearchBettingStageResponse({
    required this.count,
    required this.matches,
  });

  factory SearchBettingStageResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchBettingStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBettingStageResponseToJson(this);
}
