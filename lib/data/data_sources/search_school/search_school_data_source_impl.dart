import 'package:dio/dio.dart';
import 'package:gogo_app/data/api/search_school/search_school_api.dart';
import 'package:gogo_app/data/data_sources/search_school/search_school_data_source.dart';
import 'package:gogo_app/data/models/search_school/search_school_response.dart';
import 'package:gogo_app/data/util/execute_handle_api_call.dart';

class SearchSchoolDataSourceImpl extends SearchSchoolDataSource {
  final SearchSchoolApi _searchSchoolApi;

  SearchSchoolDataSourceImpl(Dio dio) : _searchSchoolApi = SearchSchoolApi(dio);

  @override
  Future<SearchSchoolRowModel> getSchoolInfo(String schulNm, String key,
          String type, int pIndex, int pSize) async =>
      await executeHandleApiCall(() =>
          _searchSchoolApi.getSchoolInfo(schulNm, key, type, pIndex, pSize));
}
