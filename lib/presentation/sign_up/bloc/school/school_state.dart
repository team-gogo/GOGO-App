import 'package:gogo_app/data/models/search_school/search_school_response.dart';

abstract class SchoolState {}

class InitSchoolState extends SchoolState {}

class DisableSchoolState extends SchoolState {}

class EnableSchoolState extends SchoolState {}

class ChooseSchoolState extends SchoolState {}
