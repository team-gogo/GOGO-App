import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_state.dart';

class ShellGameBloc extends Bloc<ShellgameEvent, ShellgameState> {
  ShellGameBloc() : super(ShellgameInitial()) {
    on<StartShuffle>(_onStartShuffle);
    on<UpdateCupOrder>(_onUpdateCupOrder);
    on<EndShuffle>(_onEndShuffle);
    on<NextRound>(_onNextRound);
    on<ResetGame>(_onResetGame);
    on<ClearResult>(_onClearResult);
    on<StartTimer>(_onStartTimer);
    on<UpdateTimer>(_onUpdateTimer);
    on<TimeOut>(_onTimeOut);
    on<PlaySelect>(_onPlaySelect);
  }

  void _onStartShuffle(StartShuffle event, Emitter<ShellgameState> emit) {
    emit(ShellgameShuffling(
      round: state.round,
      cupOrder: state.cupOrder,
      playSelect: state.playSelect,
    ));
  }

  void _onUpdateCupOrder(UpdateCupOrder event, Emitter<ShellgameState> emit) {
    emit(ShellgameShuffling(
      round: state.round,
      cupOrder: List<int>.from(event.cupOrder),
      playSelect: state.playSelect,
    ));
  }

  void _onEndShuffle(EndShuffle event, Emitter<ShellgameState> emit) {
    emit(ShellgameReady(
      round: state.round,
      cupOrder: state.cupOrder,
      ballPosition: event.ballPosition,
      playSelect: state.playSelect,
    ));
  }

  void _onNextRound(NextRound event, Emitter<ShellgameState> emit) {
    final currentRound = state.round;

    if (currentRound >= 5) {
      if (event.isWin) {
        final message = "야바위에 성공했습니다.";
        emit(ShellgameRound(
          round: 1,
          playSelect: -1,
          resultMessage: message,
          earnedPoints: event.earnedScore,
          isWin: true,
          cupOrder: [0, 1, 2],
        ));
      } else {
        final message = "야바위에 실패했습니다.";
        emit(ShellgameResult(
          isWin: false,
          round: currentRound,
          resultMessage: message,
          earnedPoints: -event.earnedScore,
          winResult: false,
        ));
      }
    } else {
      if (event.isWin) {
        final message = "야바위에 성공했습니다.";
        emit(ShellgameRound(
          round: currentRound + 1, 
          playSelect: -1,
          resultMessage: message,
          earnedPoints: event.earnedScore,
          isWin: true,
          cupOrder: [0, 1, 2],
        ));
      } else {
        final message = "야바위에 실패했습니다.";
        emit(ShellgameRound(
          round: 1,
          playSelect: -1,
          resultMessage: message,
          earnedPoints: -event.earnedScore,
          isWin: false,
          cupOrder: [0, 1, 2],
        ));
      }
    }
  }

  void _onResetGame(ResetGame event, Emitter<ShellgameState> emit) {
    emit(ShellgameInitial());
  }
  
  void _onClearResult(ClearResult event, Emitter<ShellgameState> emit) {
    if (state is ShellgameRound) {
      final currentState = state as ShellgameRound;
      emit(ShellgameRound(
        round: currentState.round,
        playSelect: currentState.playSelect,
      ));
    } else if (state is ShellgameResult) {
      final currentState = state as ShellgameResult;
      emit(ShellgameResult(
        isWin: currentState.isWin,
        round: currentState.round,
        playSelect: currentState.playSelect,
      ));
    }
  }

  void _onPlaySelect(PlaySelect event, Emitter<ShellgameState> emit) {
    if (state is ShellgameReady) {
      final ready = state as ShellgameReady;
      emit(ShellgameReady(
        round: ready.round,
        cupOrder: ready.cupOrder,
        ballPosition: ready.ballPosition,
        playSelect: event.select,
      ));
    } else if (state is ShellgameWaiting) {
      final waiting = state as ShellgameWaiting;
      emit(ShellgameReady(
        round: waiting.round,
        cupOrder: waiting.cupOrder,
        ballPosition: waiting.ballPosition,
        playSelect: event.select,
      ));
    } else {
      emit(ShellgameRound(
        playSelect: event.select,
        round: state.round,
      ));
    }
  }

  void _onStartTimer(StartTimer event, Emitter<ShellgameState> emit) {
    if (state is ShellgameReady) {
      final currentState = state as ShellgameReady;
      emit(ShellgameWaiting(
        round: currentState.round,
        cupOrder: currentState.cupOrder,
        ballPosition: currentState.ballPosition,
        timerSeconds: event.seconds,
      ));
    }
  }
  
  void _onUpdateTimer(UpdateTimer event, Emitter<ShellgameState> emit) {
    if (state is ShellgameWaiting) {
      final currentState = state as ShellgameWaiting;
      emit(ShellgameWaiting(
        round: currentState.round,
        cupOrder: currentState.cupOrder,
        ballPosition: currentState.ballPosition,
        timerSeconds: event.seconds,
        playSelect: currentState.playSelect,
      ));
    }
  }
  
  void _onTimeOut(TimeOut event, Emitter<ShellgameState> emit) {
    if (state is ShellgameWaiting) {
      final currentState = state as ShellgameWaiting;
      emit(ShellgameReady(
        round: currentState.round,
        cupOrder: currentState.cupOrder,
        ballPosition: currentState.ballPosition,
      ));
    }
  }
}

