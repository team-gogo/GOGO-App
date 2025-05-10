import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_counter_event.dart';
import 'character_counter_state.dart';

class CharacterCounterBloc extends Bloc<CharacterCounterEvent, CharacterCounterState> {
  CharacterCounterBloc()
      : super(CharacterCounterState(currentLength: 0)) {
    on<TextChanged>((event, emit) {
      emit(CharacterCounterState(
        currentLength: event.text.length,
        maxLength: 10,
      ));
    });
  }
}
