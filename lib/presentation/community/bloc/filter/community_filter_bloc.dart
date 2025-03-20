import 'package:bloc/bloc.dart';

import 'community_filter_event.dart';
import 'community_filter_state.dart';

class CommunitySportFilterBloc
    extends Bloc<CommunitySportFilterEvent, CommunitySportFilterState> {
  CommunitySportFilterBloc() : super(DefaultCommunitySportFilterState()) {
    on<SelectCommunitySportFilterEvent>(_handleSelectCommunitySportFilterEvent);
  }

  void _handleSelectCommunitySportFilterEvent(
      SelectCommunitySportFilterEvent event,
      Emitter<CommunitySportFilterState> emit) {
    print(event.gameType);
    if (state is SelectedCommunitySportFilterState) {
      final currentState = state as SelectedCommunitySportFilterState;
      print(currentState.gameType);
      if (event.gameType == currentState.gameType) {
        emit(DefaultCommunitySportFilterState());
      } else {
        emit(SelectedCommunitySportFilterState(gameType: event.gameType));
      }
    } else {
      emit(SelectedCommunitySportFilterState(gameType: event.gameType));
    }
  }
}

class CommunitySortFilterBloc
    extends Bloc<CommunitySortFilterEvent, CommunitySortFilterState> {
  CommunitySortFilterBloc() : super(DefaultCommunitySortFilterState()) {
    on<SelectCommunitySortFilterEvent>(_handleSelectCommunitySortFilterEvent);
  }

  void _handleSelectCommunitySortFilterEvent(
      SelectCommunitySortFilterEvent event,
      Emitter<CommunitySortFilterState> emit) {
    print(event.sortType);
    if (state is SelectedCommunitySortFilterState) {
      final currentState = state as SelectedCommunitySortFilterState;
      print(currentState.sortType);
      if (event.sortType == currentState.sortType) {
        emit(DefaultCommunitySortFilterState());
      } else {
        emit(SelectedCommunitySortFilterState(sortType: event.sortType));
      }
    } else {
      emit(SelectedCommunitySortFilterState(sortType: event.sortType));
    }
  }
}
