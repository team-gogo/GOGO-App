import 'package:gogo_app/data/models/auth/student/student_response.dart';

abstract class StageStudentManagePopupState {}

class InitStageStudentManage extends StageStudentManagePopupState {}

class SearchingStageStudentManage extends StageStudentManagePopupState {}

class SearchedStageStudentManage extends StageStudentManagePopupState {
  final List<Student> searchedStudentResponse;

  SearchedStageStudentManage(this.searchedStudentResponse);
}
