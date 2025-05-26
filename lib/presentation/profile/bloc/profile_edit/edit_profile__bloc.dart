import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_request.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile_event.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {

  final AuthRepository _authRepository = GetIt.instance<AuthRepository>();

  final TextEditingController _gradeController;
  final TextEditingController _classController;
  final TextEditingController _numberController;
  final TextEditingController _nameController;
  Sex _sexController;

  // 캐싱을 위한 변수들 추가
  final String _cachedName;
  final int _cachedGrade;
  final int _cachedClass;
  final int _cachedNumber;
  final Sex _cachedSex;
  final bool _cachedIsFiltered;

  TextEditingController get nameController => _nameController;

  TextEditingController get gradeController => _gradeController;

  TextEditingController get classController => _classController;

  TextEditingController get numberController => _numberController;


  Sex get sexController => _sexController;
  

  EditProfileBloc(
       this._nameController, this._gradeController, this._classController, this._numberController,
      Sex initialSex,
      UserInfoResponse userInfo) : _sexController = initialSex,
      _cachedName = userInfo.name,
      _cachedGrade = userInfo.grade,
      _cachedClass = userInfo.classNumber,
      _cachedNumber = userInfo.studentNumber,
      _cachedSex = userInfo.sex,
      _cachedIsFiltered = userInfo.isFiltered,
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
      
      // 변경된 정보만 포함하는 Map 생성
      final Map<String, dynamic> updateData = {};
      
      if (_nameController.text != _cachedName) {
        updateData['name'] = _nameController.text;
      }
      if (_gradeController.text != _cachedGrade.toString()) {
        updateData['grade'] = int.parse(_gradeController.text.replaceAll('학년', ''));
      }
      if (_classController.text != _cachedClass.toString()) {
        updateData['classNumber'] = int.parse(_classController.text.replaceAll('반', ''));
      }
      if (_numberController.text != _cachedNumber.toString()) {
        updateData['studentNumber'] = int.parse(_numberController.text.replaceAll('번', ''));
      }
      if (_sexController != _cachedSex) {
        updateData['sex'] = _sexController;
      }
      if (event.isFiltered != _cachedIsFiltered) {
        updateData['isFiltered'] = event.isFiltered;
      }

      // 변경된 정보가 있는 경우에만 요청
      if (updateData.isNotEmpty) {
        await _authRepository.updateUserInfo(
          UserInfoRequest(
            name: updateData['name'] ?? _cachedName,
            grade: updateData['grade'] ?? _cachedGrade,
            classNumber: updateData['classNumber'] ?? _cachedClass,
            studentNumber: updateData['studentNumber'] ?? _cachedNumber,
            sex: updateData['sex'] ?? _cachedSex,
            isFiltered: updateData['isFiltered'] ?? _cachedIsFiltered,
          ),
        );
      }
      
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
