import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_state.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final TextEditingController _schoolController;

  TextEditingController get schoolController => _schoolController;

  SchoolBloc(this._schoolController) : super(DisableSchoolState()) {
    on<EnterSchoolEvent>(_handlerEnterSchoolEvent);
    _schoolController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    add(EnterSchoolEvent());
  }

  void _handlerEnterSchoolEvent(EnterSchoolEvent event, Emitter<SchoolState> emit) {
    _schoolController.text.isNotEmpty
        ? emit(EnableSchoolState())
        : emit(DisableSchoolState());
  }
  @override
  Future<void> close() {
    _schoolController.removeListener(_onTextChanged); // 리스너 제거
    return super.close();
  }

}
