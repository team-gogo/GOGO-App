import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_event.dart';
import 'package:gogo_app/presentation/stage/bloc/stage_state.dart';
import '../../../data/repositories/stage/stage_repository.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();
  StageBloc() : super(StageInitial()){
    on<GetStageEvent>(_getStageEventHandler);
  }


  void _getStageEventHandler(StageEvent event, Emitter<StageState> emit) async {
    emit(StageLoading());
    try {
      SearchStageResponse stage = await _stageRepository.getAllStages();
      emit(StageLoaded(stage: stage));
    } catch (e) {
      emit(StageError(message: e.toString()));
    }
  }
}
