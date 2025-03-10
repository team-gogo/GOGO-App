import 'package:json_annotation/json_annotation.dart';

import '../match_round.dart';

part 'stage_confirm_request.g.dart';

@JsonSerializable()
class StateConfirmRequest {
  final int gameId;
  final Single? single;
  final List<Tournament>? tournament;
  final List<FullLeague>? fullLeague;

  StateConfirmRequest({
    required this.gameId,
    this.single,
    this.tournament,
    this.fullLeague,
  });

  factory StateConfirmRequest.fromJson(Map<String, dynamic> json) =>
      _$StateConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StateConfirmRequestToJson(this);
}

@JsonSerializable()
class Single {
  final int aTeam;
  final int bTeam;
  final String startDate;
  final String endDate;

  Single({
    required this.aTeam,
    required this.bTeam,
    required this.startDate,
    required this.endDate,
  });

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);

  Map<String, dynamic> toJson() => _$SingleToJson(this);
}

@JsonSerializable()
class Tournament {
  final int aTeam;
  final int bTeam;
  final MatchRound round;
  final int turn;
  final String startDate;
  final String endDate;

  Tournament({
    required this.aTeam,
    required this.bTeam,
    required this.round,
    required this.turn,
    required this.startDate,
    required this.endDate,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}

@JsonSerializable()
class FullLeague {
  final int aTeam;
  final int bTeam;
  final int leagueTurn;
  final String startDate;
  final String endDate;

  FullLeague({
    required this.aTeam,
    required this.bTeam,
    required this.leagueTurn,
    required this.startDate,
    required this.endDate,
  });

  factory FullLeague.fromJson(Map<String, dynamic> json) =>
      _$FullLeagueFromJson(json);

  Map<String, dynamic> toJson() => _$FullLeagueToJson(this);
}
