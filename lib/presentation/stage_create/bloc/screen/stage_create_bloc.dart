import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/stage_create/bloc/screen/stage_create_event.dart';
import 'package:gogo_app/presentation/stage_create/bloc/screen/stage_create_state.dart';

class StageCreateBloc extends Bloc<StageCreateEvent, StageCreateState> {
  StageCreateBloc() : super(InitStageCreate()) {
    on<CreateStageCreate>(_handlerCreatingStageCreateEvent);
  }

  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  void _handlerCreatingStageCreateEvent(
      CreateStageCreate event, Emitter<StageCreateState> emit) async {
    emit(CreatingStageCreate());
    try {
      await _stageRepository.createFastStage(event.request);
      emit(SuccessStageCreate());
    } catch (e) {
      emit(ErrorStageCreate(e.toString()));
      log(e.toString());
    }
  }
}
