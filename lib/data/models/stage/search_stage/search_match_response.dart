import 'package:json_annotation/json_annotation.dart';

import '../match_round.dart';

part 'search_match_response.g.dart';

@JsonSerializable()
class SearchMatchResponse {
  final int count;
  final List<Match> match;

  SearchMatchResponse({
    required this.count,
    required this.match,
  });

  factory SearchMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMatchResponseToJson(this);
}

@JsonSerializable()
class Match {
  final int matchId;
  final MatchTeam aTeam;
  final MatchTeam bTeam;
  final String startDate;
  final String endDate;
  final bool isEnd;
  final List<MatchRound>? round;
  final int? turn;
  final MatchResult? result;

  Match({
    required this.matchId,
    required this.aTeam,
    required this.bTeam,
    required this.startDate,
    required this.endDate,
    required this.isEnd,
    this.round,
    this.turn,
    this.result,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);
}

@JsonSerializable()
class MatchTeam {
  final int teamId;
  final int bettingPoint;
  final int? winCount;

  MatchTeam({
    required this.teamId,
    required this.bettingPoint,
    this.winCount,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) =>
      _$MatchTeamFromJson(json);
  Map<String, dynamic> toJson() => _$MatchTeamToJson(this);
}

@JsonSerializable()
class MatchResult {
  final int victoryTeamId;
  final int aTeamScore;
  final int bTeamScore;
  final bool? isPredictionSuccess;
  final int? earnedPoint;
  final String pointReceivingTime;

  MatchResult({
    required this.victoryTeamId,
    required this.aTeamScore,
    required this.bTeamScore,
    this.isPredictionSuccess,
    this.earnedPoint,
    required this.pointReceivingTime,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);
  Map<String, dynamic> toJson() => _$MatchResultToJson(this);
}
