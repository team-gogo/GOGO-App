abstract class ShellgameEvent {}

class PlaceBet extends ShellgameEvent {
  final int stageId;
  final int amount;

  PlaceBet({
    required this.stageId,
    required this.amount,
  });
}

class BetPlaced extends ShellgameEvent {
  final String uuid;

  BetPlaced({
    required this.uuid,
  });
}

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

class ShowSuccessModal extends ShellgameEvent {
  final int earnedPoints;

  ShowSuccessModal({
    required this.earnedPoints,
  });
}

class ContinueToNextRound extends ShellgameEvent {}

class QuitGame extends ShellgameEvent {}

class SubmitGameResult extends ShellgameEvent {
  final int stageId;
  final String proof;
  final bool isWin;
  final int finalRound;

  SubmitGameResult({
    required this.stageId,
    required this.proof,
    required this.isWin,
    required this.finalRound,
  });
}

class GameResultSubmitted extends ShellgameEvent {
  final int serverResult;

  GameResultSubmitted({
    required this.serverResult,
  });
}