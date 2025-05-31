import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_event.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_state.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();
  final MiniGameRepository _miniGameRepository = GetIt.instance<MiniGameRepository>();

  StageBloc() : super(StageInitial()) {
    on<GetStageEvent>(_getStageEventHandler);
    on<GetMinigameBetLimitEvent>(_getMinigameBetLimitEventHandler);
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

  void _getMinigameBetLimitEventHandler(
      GetMinigameBetLimitEvent event, Emitter<StageState> emit) async {
    final currentState = state;
    if (currentState is StageLoaded) {
      try {
        final betLimitResponse = await _miniGameRepository.getBetLimit(event.stageId);
        emit(StageLoaded(
          stage: currentState.stage,
          betLimitResponse: betLimitResponse,
        ));
      } catch (e) {
        print(e);
        emit(StageError(message: e.toString()));
      }
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
