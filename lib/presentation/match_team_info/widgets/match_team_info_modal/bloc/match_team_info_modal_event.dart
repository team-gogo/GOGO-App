abstract class MatchTeamInfoModalEvent {
  const MatchTeamInfoModalEvent();
}

class GetMatchTeamInfo extends MatchTeamInfoModalEvent {
  final int teamId;

  const GetMatchTeamInfo({required this.teamId});
}