import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'match_team_info_modal_event.dart';
import 'match_team_info_modal_state.dart';

class MatchTeamInfoModalBloc
    extends Bloc<MatchTeamInfoModalEvent, MatchTeamInfoModalState> {
  MatchTeamInfoModalBloc() : super(InitMatchTeamInfo()) {
    on<GetMatchTeamInfo>(_getMatchTeamInfo);
  }

  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  void _getMatchTeamInfo(
      GetMatchTeamInfo event, Emitter<MatchTeamInfoModalState> emit) async {
    emit(LoadingMatchTeamInfo());
    try {
      final response = await _stageRepository.getTeamDetail(event.teamId);
      emit(LoadedMatchTeamInfo(teamInfoResponse: response));
    } catch (e) {
      emit(ErrorMatchTeamInfo(error: e.toString()));
    }
  }
}
