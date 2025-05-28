abstract class ShellgameState {
  final int round;
  final int maxRound;
  final bool isGameOver;
  final int playSelect;

  ShellgameState({
    this.round = 1,
    this.maxRound = 5,
    this.isGameOver = false,
    this.playSelect = -1,
  });
}

class ShellgameInitial extends ShellgameState {
  ShellgameInitial() : super();
}

class ShellgameRound extends ShellgameState {
  ShellgameRound({
    required int round,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
        );
}

class ShellgameResult extends ShellgameState {
  final bool isWin;

  ShellgameResult({
    required this.isWin,
    required int round,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isGameOver: round >= 5,
        );
}