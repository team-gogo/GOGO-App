import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_event.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_state.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  StageBloc() : super(StageInitial()) {
    on<GetStageEvent>(_getStageEventHandler);
    on<EnterStageEvent>(_enterStageEventHandler);
  }

  void _getStageEventHandler(StageEvent event, Emitter<StageState> emit) async {
    emit(StageLoading());
    try {
      SearchStageResponse stage = await _stageRepository.getAllStages();
      emit(StageLoaded(stage: stage));
    } catch (e) {
      print(e);
      emit(StageError(message: e.toString()));
    }
  }

  void _enterStageEventHandler(
      EnterStageEvent event, Emitter<StageState> emit) async {
    try {
      await _stageRepository.joinStage(event.stageId, event.body);
    } catch (e) {
      print(e);
      emit(StageError(message: e.toString()));
    }
  }
}
