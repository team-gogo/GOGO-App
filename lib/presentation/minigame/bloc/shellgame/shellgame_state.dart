abstract class ShellgameState {
  final int round;
  final int maxRound;
  final bool isGameOver;
  final int playSelect;
  final bool isShuffling;
  final bool isGameStarted;
  final List<int> cupOrder;
  final int ballPosition;
  final String? resultMessage;
  final int? earnedPoints;
  final bool? isWin;
  final bool isTimerRunning;
  final int timerSeconds;

  ShellgameState({
    this.round = 1,
    this.maxRound = 5,
    this.isGameOver = false,
    this.playSelect = -1,
    this.isShuffling = false,
    this.isGameStarted = false,
    List<int>? cupOrder,
    this.ballPosition = -1,
    this.resultMessage,
    this.earnedPoints,
    this.isWin,
    this.isTimerRunning = false,
    this.timerSeconds = 10,
  }) : cupOrder = cupOrder ?? [0, 1, 2];
}

class ShellgameInitial extends ShellgameState {
  ShellgameInitial() : super();
}

class ShellgameShuffling extends ShellgameState {
  ShellgameShuffling({
    required int round,
    required List<int> cupOrder,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: true,
          isGameStarted: true,
          cupOrder: List<int>.from(cupOrder),
        );
}

class ShellgameReady extends ShellgameState {
  ShellgameReady({
    required int round,
    required List<int> cupOrder,
    required int ballPosition,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: false,
          isGameStarted: true,
          cupOrder: List<int>.from(cupOrder),
          ballPosition: ballPosition,
        );
}

class ShellgameWaiting extends ShellgameState {
  ShellgameWaiting({
    required int round,
    required List<int> cupOrder,
    required int ballPosition,
    required int timerSeconds,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: false,
          isGameStarted: true,
          cupOrder: List<int>.from(cupOrder),
          ballPosition: ballPosition,
          isTimerRunning: true,
          timerSeconds: timerSeconds,
        );
}

class ShellgameRound extends ShellgameState {
  ShellgameRound({
    required int round,
    int playSelect = -1,
    String? resultMessage,
    int? earnedPoints,
    bool? isWin,
    List<int>? cupOrder,
  }) : super(
          round: round,
          playSelect: playSelect,
          resultMessage: resultMessage,
          earnedPoints: earnedPoints,
          isWin: isWin,
          cupOrder: cupOrder ?? [0, 1, 2],
        );
}

class ShellgameResult extends ShellgameState {
  final bool isWin;

  ShellgameResult({
    required this.isWin,
    required int round,
    int playSelect = -1,
    String? resultMessage,
    int? earnedPoints,
    bool? winResult,
  }) : super(
          round: round,
          playSelect: playSelect,
          isGameOver: round >= 5,
          resultMessage: resultMessage,
          earnedPoints: earnedPoints,
          isWin: winResult,
        );
}