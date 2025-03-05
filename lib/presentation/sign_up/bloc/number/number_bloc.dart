import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogo_app/presentation/sign_up/bloc/number/number_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/number/number_state.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  final TextEditingController _gradeController;
  final TextEditingController _classController;
  final TextEditingController _numberController;

  TextEditingController get gradeController => _gradeController;

  TextEditingController get classController => _classController;

  TextEditingController get numberController => _numberController;

  NumberBloc(
      this._gradeController, this._classController, this._numberController)
      : super(DisableNumberState()) {
    on<EnterNumberEvent>(_handlerEnterNumberEvent);

    _gradeController.addListener(_onTextChanged);
    _classController.addListener(_onTextChanged);
    _numberController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    add(EnterNumberEvent());
  }

  String? gradeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '학년을 입력해주세요.';
    }
    final number = int.tryParse(value.replaceAll('학년', '').trim());
    if (number == null || number < 1 || number > 6) {
      return '학년은 1~6 사이의 숫자여야 합니다.';
    }
    return null;
  }

  String? classValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '반을 입력해주세요.';
    }
    final number = int.tryParse(value.replaceAll('반', '').trim());
    if (number == null || number < 1 || number > 30) {
      return '반은 1~30 사이의 숫자여야 합니다.';
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '번호를 입력해주세요.';
    }
    final number = int.tryParse(value.replaceAll('번', '').trim());
    if (number == null || number < 1 || number > 50) {
      return '번호는 1~50 사이의 숫자여야 합니다.';
    }
    return null;
  }

  void _handlerEnterNumberEvent(
      EnterNumberEvent event, Emitter<NumberState> emit) {
    final isValidGrade = gradeValidator(_gradeController.text) == null;
    final isValidClass = classValidator(_classController.text) == null;
    final isValidNumber = numberValidator(_numberController.text) == null;

    if (isValidGrade && isValidClass && isValidNumber) {
      emit(EnableNumberState());
    } else {
      emit(DisableNumberState());
    }
  }

  @override
  Future<void> close() {
    _gradeController.removeListener(_onTextChanged); // 리스너 제거
    _classController.removeListener(_onTextChanged); // 리스너 제거
    _numberController.removeListener(_onTextChanged); // 리스너 제거
    return super.close();
  }
}
