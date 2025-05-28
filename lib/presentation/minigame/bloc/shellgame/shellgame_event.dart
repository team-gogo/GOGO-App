abstract class ShellgameEvent {}

class NextRound extends ShellgameEvent {
  final bool isWin;
  final int earnedScore;

  NextRound({
    required this.isWin,
    required this.earnedScore,
  });
}

class ResetGame extends ShellgameEvent {}

class PlaySelect extends ShellgameEvent {
  final int select;

  PlaySelect({
    required this.select,
  });
}