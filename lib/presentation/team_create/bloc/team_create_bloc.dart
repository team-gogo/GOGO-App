import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_event.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_state.dart';

class TeamCreateBloc extends Bloc<TeamCreateEvent, TeamCreateState> {
  TeamCreateBloc() : super(TeamCreateInitialState()) {
    on<PostTeamCreateEvent>(_onPostTeamCreateEvent);
  }

  final StageRepository _stageRepository =
      GetIt.instance.get<StageRepository>();

  void _onPostTeamCreateEvent(
      PostTeamCreateEvent event, Emitter<TeamCreateState> emit) async {
    emit(TeamCreateLoadingState());
    try {
      await _stageRepository.applyTeam(event.gameId, event.teamApplyRequest);
      emit(TeamCreateSuccessState());
    } catch (e) {
      emit(TeamCreateFailureState(errorMessage: e.toString()));
    }
  }
}
