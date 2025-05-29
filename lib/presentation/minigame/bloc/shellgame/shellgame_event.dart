abstract class ShellgameEvent {}

class StartShuffle extends ShellgameEvent {}

class UpdateCupOrder extends ShellgameEvent {
  final List<int> cupOrder;
  
  UpdateCupOrder({required this.cupOrder});
}

class EndShuffle extends ShellgameEvent {
  final int ballPosition;
  
  EndShuffle({required this.ballPosition});
}

class NextRound extends ShellgameEvent {
  final bool isWin;
  final int earnedScore;

  NextRound({
    required this.isWin,
    required this.earnedScore,
  });
}

class ResetGame extends ShellgameEvent {}

class ClearResult extends ShellgameEvent {}

class StartTimer extends ShellgameEvent {
  final int seconds;
  
  StartTimer({this.seconds = 10});
}

class UpdateTimer extends ShellgameEvent {
  final int seconds;
  
  UpdateTimer({required this.seconds});
}

class TimeOut extends ShellgameEvent {}

class PlaySelect extends ShellgameEvent {
  final int select;

  PlaySelect({
    required this.select,
  });
}