import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_game_format_response.g.dart';

@JsonSerializable()
class  SearchGameFormatResponse {
  final List<Format> format;

  SearchGameFormatResponse({
    required this.format,
  });

  factory SearchGameFormatResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchGameFormatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchGameFormatResponseToJson(this);
}

@JsonSerializable()
class Format {
  final MatchRound round;
  final List<TournamentMatch> match;

  Format({
    required this.round,
    required this.match,
  });

  factory Format.fromJson(Map<String, dynamic> json) => _$FormatFromJson(json);

  Map<String, dynamic> toJson() => _$FormatToJson(this);
}

@JsonSerializable()
class TournamentMatch {
  final int matchId;
  final int turn;
  final int? aTeamId;
  final String aTeamName;
  final int? bTeamId;
  final String bTeamName;
  final bool isEnd;
  final int? winTeamId;

  TournamentMatch({
    required this.matchId,
    required this.turn,
    this.aTeamId,
    required this.aTeamName,
    this.bTeamId,
    required this.bTeamName,
    required this.isEnd,
    this.winTeamId = -1,
  });

  factory TournamentMatch.fromJson(Map<String, dynamic> json) =>
      _$TournamentMatchFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentMatchToJson(this);
}
