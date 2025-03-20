import 'package:gogo_app/data/models/stage/game_type.dart';
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

  factory Betting.fromJson(Map<String, dynamic> json) => _$BettingFromJson(json);
  Map<String, dynamic> toJson() => _$BettingToJson(this);
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

  factory MatchResult.fromJson(Map<String, dynamic> json) => _$MatchResultFromJson(json);
  Map<String, dynamic> toJson() => _$MatchResultToJson(this);
}

@JsonSerializable()
class Match {
  final int matchId;
  final Team aTeam;
  final Team bTeam;
  final DateTime startDate;
  final DateTime endDate;
  final bool isEnd;
  final List<MatchRound>? round;
  final List<GameType> category;
  final List<System> system;
  final String gameName;
  final int? turn;
  final bool isNotice;
  final Betting betting;
  final MatchResult? result;

  Match({
    required this.matchId,
    required this.aTeam,
    required this.bTeam,
    required this.startDate,
    required this.endDate,
    required this.isEnd,
    this.round,
    required this.category,
    required this.system,
    required this.gameName,
    this.turn,
    required this.isNotice,
    required this.betting,
    this.result,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);
}

@JsonSerializable()
class SearchBettingStageResponse {
  final int count;
  final List<Match> matches;

  SearchBettingStageResponse({
    required this.count,
    required this.matches,
  });

  factory SearchBettingStageResponse.fromJson(Map<String, dynamic> json) => _$SearchBettingStageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchBettingStageResponseToJson(this);
}
