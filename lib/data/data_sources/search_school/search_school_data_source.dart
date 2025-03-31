import 'package:gogo_app/data/models/search_school/search_school_response.dart';

abstract class SearchSchoolDataSource {
  Future<SearchSchoolRowModel> getSchoolInfo(String schulNm);
}