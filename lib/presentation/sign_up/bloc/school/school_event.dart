import 'package:gogo_app/data/models/search_school/search_school_response.dart';

abstract class SchoolEvent {}

class EnterSchoolEvent extends SchoolEvent {
  final String search;

  EnterSchoolEvent(this.search);
}

class ChooseSchoolEvent extends SchoolEvent {
  final SearchSchoolResponse searchSchoolResponse;

  ChooseSchoolEvent(this.searchSchoolResponse);
}
