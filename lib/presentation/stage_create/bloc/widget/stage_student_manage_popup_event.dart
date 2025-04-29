import '../../../../data/models/auth/student/student_response.dart';

class StageStudentManagePopupEvent {}

class SearchingStudentEvent extends StageStudentManagePopupEvent {
  final String searchText;

  SearchingStudentEvent(this.searchText);
}
