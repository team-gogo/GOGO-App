import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:gogo_app/presentation/stage_create/bloc/stage_create_event.dart';
import 'package:gogo_app/presentation/stage_create/bloc/stage_create_state.dart';

class StageCreateBloc extends Bloc<StageCreateEvent, StageCreateState> {
  StageCreateBloc() : super(InitStageCreate()) {
    on<CreateStageCreate>(_handlerCreatingStageCreateEvent);
  }

  void _handlerCreatingStageCreateEvent(
      CreateStageCreate event, Emitter<StageCreateState> emit) async {
    emit(CreatingStageCreate());
    try {} catch (e) {
      log(e.toString());
    }
  }
}
