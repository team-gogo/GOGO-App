class TempTeamEvent {}

class GetTempTeamEvent extends TempTeamEvent {
  final int gameId;

  GetTempTeamEvent({required this.gameId});
}
