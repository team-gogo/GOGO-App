import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_state.dart';

class ShellGameBloc extends Bloc<ShellgameEvent, ShellgameState> {
  ShellGameBloc() : super(ShellgameInitial()) {
    on<NextRound>(_onNextRound);
    on<ResetGame>(_onResetGame);
  }

  void _onNextRound(NextRound event, Emitter<ShellgameState> emit) {
    final currentRound = state.round;

    if (currentRound >= 5) {
      emit(ShellgameResult(
        isWin: event.isWin,
        round: currentRound,
      ));
    } else {
      if (event.isWin) {
        emit(ShellgameRound(
          round: currentRound + 1, 
          playSelect: 0,
        ));
      } else {
        emit(ShellgameResult(
          isWin: false,
          round: currentRound,
        ));
      }
    }
  }

  void _onResetGame(ResetGame event, Emitter<ShellgameState> emit) {
    emit(ShellgameInitial());
  }
  void _onPlaySelect(PlaySelect event, Emitter<ShellgameState> emit) {
    emit(ShellgameRound(
      playSelect: event.select,
      round: state.round,
    ));
  }
}

