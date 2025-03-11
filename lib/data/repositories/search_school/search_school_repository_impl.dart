import 'package:gogo_app/data/data_sources/search_school/search_school_data_source.dart';
import 'package:gogo_app/data/models/search_school/search_school_response.dart';
import 'package:gogo_app/data/repositories/search_school/search_school_repository.dart';

class SearchSchoolRepositoryImpl extends SearchSchoolRepository {
  final SearchSchoolDataSource searchSchoolDataSource;

  SearchSchoolRepositoryImpl(this.searchSchoolDataSource);

  @override
  Future<SearchSchoolRowModel> getSchoolInfo(String schulNm, String key,
          String type, int pIndex, int pSize) async =>
      await searchSchoolDataSource.getSchoolInfo(
          schulNm, key, type, pIndex, pSize);
}
