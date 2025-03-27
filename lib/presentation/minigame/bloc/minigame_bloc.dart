import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_state.dart';

// 📌 BLoC 정의
class MinigameDescriptionBloc
    extends Bloc<MinigameDescriptionEvent, MinigameDescriptionState> {
  MinigameDescriptionBloc() : super(MinigameDescriptionInitial()) {
    on<ChangeCategory>(_onUpdateGameCategory);
  }

  void _onUpdateGameCategory(
      ChangeCategory event, Emitter<MinigameDescriptionState> emit) {
    emit(MinigameDescriptionUpdated(selectedIndex: event.selectedIndex));
  }
}
