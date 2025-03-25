import 'package:json_annotation/json_annotation.dart';
import '../../common/team_response.dart';

part 'search_participation_match_response.g.dart';

@JsonSerializable()
class SearchParticipationMatchResponse {
  final int count;
  final List<Team> team;

  SearchParticipationMatchResponse({
    required this.count,
    required this.team,
  });

  factory SearchParticipationMatchResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SearchParticipationMatchResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SearchParticipationMatchResponseToJson(this);
}
