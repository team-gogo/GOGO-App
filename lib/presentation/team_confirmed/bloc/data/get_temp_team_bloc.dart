import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/data/get_temp_team_event.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/data/get_temp_team_state.dart';

import '../../../../data/models/stage/search_stage/search_team_temp_response.dart';
import '../../../../data/repositories/stage/stage_repository.dart';


class GetTempTeamBloc extends Bloc<TempTeamEvent, GetTempTeamState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  GetTempTeamBloc() : super(GetTempTeamInitial()) {
    on<GetTempTeamEvent>(_getGameEventHandler);
  }

  void _getGameEventHandler(GetTempTeamEvent event, Emitter<GetTempTeamState> emit) async {
    emit(GetTempTeamLoading());
    try {
      SearchTempTeamResponse tempTeamResponse = await _stageRepository.getTempTeams(event.gameId);
      emit(GetTempTeamLoaded(tempTeamResponse: tempTeamResponse));
    } catch (e) {
      emit(GetTempTeamError(message: e.toString()));
    }
  }
}
