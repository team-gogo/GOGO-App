import '../../../../data/models/auth/additional_sign_up/additional_sign_up_response.dart';

abstract class SchoolEvent {}

class EnterSchoolEvent extends SchoolEvent {
  final String search;

  EnterSchoolEvent(this.search);
}

class ChooseSchoolEvent extends SchoolEvent {
  final School searchSchoolResponse;

  ChooseSchoolEvent(this.searchSchoolResponse);
}
