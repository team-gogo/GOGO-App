abstract class MiniGameState {}

class MiniGameInitial extends MiniGameState {}

class MiniGameSelected extends MiniGameState {
  final String? selectedGame;
  MiniGameSelected(this.selectedGame);
}
