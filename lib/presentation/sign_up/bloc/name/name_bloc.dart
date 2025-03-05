import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogo_app/presentation/sign_up/bloc/name/name_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/name/name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  final TextEditingController _nameController;

  TextEditingController get nameController => _nameController;

  NameBloc(this._nameController) : super(DisableNameState()) {
    on<EnterNameEvent>(_handlerEnterNameEvent);
    _nameController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    add(EnterNameEvent());
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요.';
    }
    // 이름이 최소 2글자 이상이어야 함
    if (value.length < 2) {
      return '이름은 최소 2글자 이상이어야 합니다.';
    }
    // 이름에 숫자나 특수문자가 포함되지 않도록 검증
    if (!RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(value)) {
      return '이름에는 숫자나 특수문자가 포함될 수 없습니다.';
    }
    return null; // 유효성 검사 통과
  }

  void _handlerEnterNameEvent(EnterNameEvent event, Emitter<NameState> emit) {
    validateName(_nameController.text) == null && _nameController.text.isNotEmpty
        ? emit(EnableNameState())
        : emit(DisableNameState());
  }
  @override
  Future<void> close() {
    _nameController.removeListener(_onTextChanged); // 리스너 제거
    return super.close();
  }

}
