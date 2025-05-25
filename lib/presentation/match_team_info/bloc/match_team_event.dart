abstract class MatchTeamEvent {
  const MatchTeamEvent();
}

class GetGameList extends MatchTeamEvent {
  final int stageId;

  const GetGameList({required this.stageId});
}

class GetMatchTeam extends MatchTeamEvent {
  const GetMatchTeam();
}
