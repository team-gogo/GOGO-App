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
  final String? betUuid;
  final bool isBetting;
  final bool isSubmittingResult;
  final int? serverResult;
  final bool showSuccessModal;

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
    this.betUuid,
    this.isBetting = false,
    this.isSubmittingResult = false,
    this.serverResult,
    this.showSuccessModal = false,
  }) : cupOrder = cupOrder ?? [0, 1, 2];
}

class ShellgameInitial extends ShellgameState {
  ShellgameInitial() : super();
}

class ShellgameBetting extends ShellgameState {
  ShellgameBetting({
    required int round,
  }) : super(
          round: round,
          isBetting: true,
        );
}

class ShellgameShuffling extends ShellgameState {
  ShellgameShuffling({
    required int round,
    required List<int> cupOrder,
    String? betUuid,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: true,
          isGameStarted: true,
          cupOrder: List<int>.from(cupOrder),
          betUuid: betUuid,
        );
}

class ShellgameReady extends ShellgameState {
  ShellgameReady({
    required int round,
    required List<int> cupOrder,
    required int ballPosition,
    String? betUuid,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: false,
          isGameStarted: true,
          cupOrder: List<int>.from(cupOrder),
          ballPosition: ballPosition,
          betUuid: betUuid,
        );
}

class ShellgameWaiting extends ShellgameState {
  ShellgameWaiting({
    required int round,
    required List<int> cupOrder,
    required int ballPosition,
    required int timerSeconds,
    String? betUuid,
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
          betUuid: betUuid,
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
    String? betUuid,
  }) : super(
          round: round,
          playSelect: playSelect,
          resultMessage: resultMessage,
          earnedPoints: earnedPoints,
          isWin: isWin,
          cupOrder: cupOrder ?? [0, 1, 2],
          betUuid: betUuid,
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
    String? betUuid,
    bool isSubmittingResult = false,
    int? serverResult,
  }) : super(
          round: round,
          playSelect: playSelect,
          isGameOver: round >= 5,
          resultMessage: resultMessage,
          earnedPoints: earnedPoints,
          isWin: winResult,
          betUuid: betUuid,
          isSubmittingResult: isSubmittingResult,
          serverResult: serverResult,
        );
}

class ShellgameSuccess extends ShellgameState {
  final int earnedPoints;

  ShellgameSuccess({
    required int round,
    required List<int> cupOrder,
    required int ballPosition,
    required this.earnedPoints,
    String? betUuid,
    int playSelect = -1,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: false,
          isGameStarted: true,
          cupOrder: List<int>.from(cupOrder),
          ballPosition: ballPosition,
          earnedPoints: earnedPoints,
          isWin: true,
          betUuid: betUuid,
        );
}

class ShellgameGameState extends ShellgameState {
  ShellgameGameState({
    required int round,
    int playSelect = -1,
    bool isShuffling = false,
    bool isGameStarted = false,
    List<int>? cupOrder,
    int ballPosition = -1,
    String? resultMessage,
    int? earnedPoints,
    bool? isWin,
    bool isTimerRunning = false,
    int timerSeconds = 10,
    String? betUuid,
    bool isBetting = false,
    bool isSubmittingResult = false,
    int? serverResult,
    bool showSuccessModal = false,
    bool isGameOver = false,
  }) : super(
          round: round,
          playSelect: playSelect,
          isShuffling: isShuffling,
          isGameStarted: isGameStarted,
          cupOrder: cupOrder ?? [0, 1, 2],
          ballPosition: ballPosition,
          resultMessage: resultMessage,
          earnedPoints: earnedPoints,
          isWin: isWin,
          isTimerRunning: isTimerRunning,
          timerSeconds: timerSeconds,
          betUuid: betUuid,
          isBetting: isBetting,
          isSubmittingResult: isSubmittingResult,
          serverResult: serverResult,
          showSuccessModal: showSuccessModal,
          isGameOver: isGameOver,
        );

  ShellgameGameState copyWith({
    int? round,
    int? maxRound,
    bool? isGameOver,
    int? playSelect,
    bool? isShuffling,
    bool? isGameStarted,
    List<int>? cupOrder,
    int? ballPosition,
    String? resultMessage,
    int? earnedPoints,
    bool? isWin,
    bool? isTimerRunning,
    int? timerSeconds,
    String? betUuid,
    bool? isBetting,
    bool? isSubmittingResult,
    int? serverResult,
    bool? showSuccessModal,
  }) {
    return ShellgameGameState(
      round: round ?? this.round,
      playSelect: playSelect ?? this.playSelect,
      isShuffling: isShuffling ?? this.isShuffling,
      isGameStarted: isGameStarted ?? this.isGameStarted,
      cupOrder: cupOrder ?? List<int>.from(this.cupOrder),
      ballPosition: ballPosition ?? this.ballPosition,
      resultMessage: resultMessage,
      earnedPoints: earnedPoints,
      isWin: isWin,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      betUuid: betUuid ?? this.betUuid,
      isBetting: isBetting ?? this.isBetting,
      isSubmittingResult: isSubmittingResult ?? this.isSubmittingResult,
      serverResult: serverResult,
      showSuccessModal: showSuccessModal ?? this.showSuccessModal,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}