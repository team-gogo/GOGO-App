import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/community/bloc/community_event.dart';
import 'package:gogo_app/presentation/community/bloc/community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  static const int maxLength = 30;

  CommunityBloc()
      : super(CommunityState(title: '', content: '', isValid: false)) {
    on<TitleChanged>((event, emit) {
      final newTitle = event.title.length > maxLength
          ? event.title.substring(0, maxLength)
          : event.title;
      emit(state.copyWith(
        title: newTitle,
        isValid: newTitle.isNotEmpty && state.content.isNotEmpty,
      ));
    });
    on<ContentChanged>((event, emit) {
      final newContent = event.content.length > maxLength
          ? event.content.substring(0, maxLength)
          : event.content;
      emit(state.copyWith(
        content: newContent,
        isValid: state.title.isNotEmpty && newContent.isNotEmpty,
      ));
    });
  }
}

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
