import 'package:bloc/bloc.dart';
import 'match_card_event.dart';
import 'match_card_state.dart';

class MatchCardAlertBloc
    extends Bloc<MatchCardAlertEvent, MatchCardAlertState> {
  MatchCardAlertBloc(super.initialState) {
    on<ClickMatchCardAlertEvent>(_handlerClickMatchCardAlertEvent);
  }

  void _handlerClickMatchCardAlertEvent(
      MatchCardAlertEvent event, Emitter<MatchCardAlertState> emit) {
    /// 알람 로직
    emit(state is DisableMatchCardAlertState
        ? EnableMatchCardAlertState()
        : DisableMatchCardAlertState());
  }
}

class MatchCardBettingBloc
    extends Bloc<MatchCardBettingEvent, MatchCardBettingState> {
  MatchCardBettingBloc(super.initialState) {
    on<ClickMatchCardBettingEvent>(_handlerClickMatchCardBettingEvent);
  }

  void _handlerClickMatchCardBettingEvent(
      MatchCardBettingEvent event, Emitter<MatchCardBettingState> emit) {
    /// 배팅 로직
    emit(state is DisableMatchCardBettingState
        ? EnableMatchCardBettingState()
        : DisableMatchCardBettingState());
  }
}
