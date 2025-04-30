import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/auth/student/student_response.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/stage_create/bloc/widget/stage_student_manage_popup_event.dart';
import 'package:gogo_app/presentation/stage_create/bloc/widget/stage_student_manage_popup_state.dart';
import 'package:rxdart/rxdart.dart';

class StageStudentManagePopupBloc
    extends Bloc<StageStudentManagePopupEvent, StageStudentManagePopupState> {
  StageStudentManagePopupBloc() : super(InitStageStudentManage()) {
    on<SearchingStudentEvent>(
      _handlerSearchingStudentEvent,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .flatMap(mapper),
    );
    searchStudentController.addListener(_onTextChanged);
  }

  final TextEditingController searchStudentController = TextEditingController();
  final AuthRepository _authRepository = GetIt.instance<AuthRepository>();

  void _onTextChanged() {
    add(SearchingStudentEvent(searchStudentController.text));
  }

  void _handlerSearchingStudentEvent(SearchingStudentEvent event,
      Emitter<StageStudentManagePopupState> emit) async {
    emit(SearchingStageStudentManage());
    try {
      final result = await _authRepository.searchStudent(event.searchText);
      emit(SearchedStageStudentManage(result.students));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    searchStudentController.removeListener(_onTextChanged);
    return super.close();
  }
}
