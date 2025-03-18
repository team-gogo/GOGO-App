abstract class MiniGameEvent {}

class SelectGame extends MiniGameEvent {
  final String? game;
  SelectGame(this.game);
}
