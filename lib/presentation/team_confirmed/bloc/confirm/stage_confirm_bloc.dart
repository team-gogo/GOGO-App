import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/confirm/stage_confirm_event.dart';
import 'package:gogo_app/presentation/team_confirmed/bloc/confirm/stage_confirm_state.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_event.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_state.dart';

class StageConfirmBloc extends Bloc<StageConfirmEvent, StageConfirmState> {
  StageConfirmBloc() : super(StageConfirmInitial()) {
    on<PostStageConfirmEvent>(_onPostStageConfirmEvent);
  }

  final StageRepository _stageRepository =
      GetIt.instance.get<StageRepository>();

  void _onPostStageConfirmEvent(
      PostStageConfirmEvent event, Emitter<StageConfirmState> emit) async {
    emit(StageConfirmLoading());
    try {
      await _stageRepository.confirmStage(
          event.stageId, event.stateConfirmRequest);
      emit(StageConfirmSuccess());
    } catch (e) {
      emit(StageConfirmFailure(errorMessage: e.toString()));
    }
  }
}
