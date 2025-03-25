import 'package:gogo_app/data/models/common/team_response.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/match_round.dart';
import 'package:gogo_app/data/models/stage/enum_type/system_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_match_info_response.g.dart';

@JsonSerializable()
class SearchMatchInfoResponse {
  final int matchId;
  final Team aTeam;
  final Team bTeam;
  final DateTime startDate;
  final DateTime endDate;
  final bool isEnd;
  final MatchRound? round;
  final GameType category;
  final System system;
  final String gameName;
  final int? turn;

  SearchMatchInfoResponse({
    required this.matchId,
    required this.aTeam,
    required this.bTeam,
    required this.startDate,
    required this.endDate,
    required this.isEnd,
    required this.round,
    required this.category,
    required this.system,
    required this.gameName,
    required this.turn,
  });

  factory SearchMatchInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMatchInfoResponseToJson(this);
}
