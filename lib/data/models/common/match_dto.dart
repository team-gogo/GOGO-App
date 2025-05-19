import 'package:gogo_app/data/models/stage/search_stage/search_betting_stage_response.dart';
import 'package:json_annotation/json_annotation.dart';
import '../stage/enum_type/game_type.dart';
import '../stage/enum_type/match_round.dart';
import '../stage/enum_type/system_type.dart';

part 'match_dto.g.dart';

@JsonSerializable()
class MatchDto {
  final int matchId;
  final MatchTeam aTeam;
  final MatchTeam bTeam;
  final DateTime startDate;
  final DateTime endDate;
  final bool isEnd;
  final MatchRound? round;
  final GameType category;
  final String gameName;
  final System system;
  final int? turn;
  final bool isNotice;
  final Betting betting;
  final MatchResult? result;
  final bool isPlayer;

  MatchDto({
    required this.matchId,
    required this.aTeam,
    required this.bTeam,
    required this.startDate,
    required this.endDate,
    required this.isEnd,
    this.round,
    required this.category,
    required this.gameName,
    required this.system,
    this.turn,
    required this.isNotice,
    required this.betting,
    this.result,
    required this.isPlayer,
  });

  factory MatchDto.fromJson(Map<String, dynamic> json) =>
      _$MatchDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MatchDtoToJson(this);
}

@JsonSerializable()
class MatchResult {
  final int victoryTeamId;
  final int aTeamScore;
  final int bTeamScore;
  final bool? isPredictionSuccess;
  final int? earnedPoint;
  final DateTime tempPointExpiredDate;

  MatchResult({
    required this.victoryTeamId,
    required this.aTeamScore,
    required this.bTeamScore,
    this.isPredictionSuccess,
    this.earnedPoint,
    required this.tempPointExpiredDate,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);

  Map<String, dynamic> toJson() => _$MatchResultToJson(this);
}

@JsonSerializable()
class MatchTeam {
  final int? teamId;
  final String teamName;
  final int bettingPoint;
  final int? winCount;

  MatchTeam({
    this.teamId,
    required this.teamName,
    required this.bettingPoint,
    this.winCount,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) =>
      _$MatchTeamFromJson(json);

  Map<String, dynamic> toJson() => _$MatchTeamToJson(this);
}
