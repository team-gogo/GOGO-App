import 'package:bloc/bloc.dart';

import 'minigame_event.dart';
import 'minigame_state.dart';

class MiniGameBloc extends Bloc<MiniGameEvent, MiniGameState> {
  MiniGameBloc() : super(MiniGameInitial()) {
    on<SelectGame>((event, emit) {
      emit(MiniGameSelected(event.game));
    });
  }
}
