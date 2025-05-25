import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_request.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile_event..dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {

  final AuthRepository _authRepository = GetIt.instance<AuthRepository>();

  final TextEditingController _gradeController;
  final TextEditingController _classController;
  final TextEditingController _numberController;
  final TextEditingController _nameController;
  Sex _sexController;

  TextEditingController get nameController => _nameController;

  TextEditingController get gradeController => _gradeController;

  TextEditingController get classController => _classController;

  TextEditingController get numberController => _numberController;


  Sex get sexController => _sexController;
  

  EditProfileBloc(
       this._nameController, this._gradeController, this._classController, this._numberController,
      Sex initialSex) : _sexController = initialSex,
      super(DisableUserInfoState()) {
    on<EnterUserInfoEvent>(_handlerEnterUserInfoEvent);
    on<UpdateProfileEvent>(_handlerUpdateProfileEvent);
    on<UpdateSexEvent>(_handlerUpdateSexEvent);

    _gradeController.addListener(_onTextChanged);
    _classController.addListener(_onTextChanged);
    _numberController.addListener(_onTextChanged);
    _nameController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    add(EnterUserInfoEvent());
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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요.';
    }
    return null;
  }

  void _handlerEnterUserInfoEvent(
      EnterUserInfoEvent event, Emitter<EditProfileState> emit) {
    final isValidGrade = gradeValidator(_gradeController.text) == null;
    final isValidClass = classValidator(_classController.text) == null;
    final isValidNumber = numberValidator(_numberController.text) == null;
    final isValidName = nameValidator(_nameController.text) == null;

    if (isValidGrade && isValidClass && isValidNumber && isValidName) {
      emit(EnableUserInfoState());
    } else {
      emit(DisableUserInfoState());
    }
  }

  void _handlerUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<EditProfileState> emit) async {
    try {
      emit(EditProfileLoading());
      await _authRepository.updateUserInfo(
        UserInfoRequest(
          grade: int.parse(_gradeController.text.replaceAll('학년', '')),
          classNumber: int.parse(_classController.text.replaceAll('반', '')),
          studentNumber: int.parse(_numberController.text.replaceAll('번', '')),
          name: _nameController.text,
          sex: _sexController,
          isFiltered: event.isFiltered,
        ),
      );
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileFailure(e.toString()));
    }
  }

  void _handlerUpdateSexEvent(UpdateSexEvent event, Emitter<EditProfileState> emit) {
    _sexController = event.sex;
    emit(state);
  }

  @override
  Future<void> close() {
    _gradeController.removeListener(_onTextChanged);
    _classController.removeListener(_onTextChanged); 
    _numberController.removeListener(_onTextChanged); 
    _nameController.removeListener(_onTextChanged);
    return super.close();
  }
}
