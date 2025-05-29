import 'package:flutter_bloc/flutter_bloc.dart';
import 'team_select_event.dart';
import 'team_select_state.dart';

class TeamSelectBloc extends Bloc<TeamSelectEvent, TeamSelectState> {
  TeamSelectBloc() : super(const TeamSelectState()) {
    on<ToggleTeamSelection>((event, emit) {
      final newSet = Set<int>.from(state.selectedTeamIds);
      if (newSet.contains(event.teamId)) {
        newSet.remove(event.teamId);
      } else {
        newSet.add(event.teamId);
      }
      emit(state.copyWith(selectedTeamIds: newSet));
    });
  }
}
