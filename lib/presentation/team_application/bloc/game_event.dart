class GameEvent {}

class GetGameEvent extends GameEvent {
  final int stageId;

  GetGameEvent({required this.stageId});
}
