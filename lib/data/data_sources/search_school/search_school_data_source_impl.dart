import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gogo_app/data/api/search_school/search_school_api.dart';
import 'package:gogo_app/data/data_sources/search_school/search_school_data_source.dart';
import 'package:gogo_app/data/models/search_school/search_school_response.dart';
import 'package:gogo_app/data/util/execute_handle_api_call.dart';

class SearchSchoolDataSourceImpl extends SearchSchoolDataSource {
  final SearchSchoolApi _searchSchoolApi;

  SearchSchoolDataSourceImpl(Dio dio) : _searchSchoolApi = SearchSchoolApi(dio);

  @override
  Future<SearchSchoolRowModel> getSchoolInfo(String schulNm) async =>
      await executeHandleApiCall(() => _searchSchoolApi.getSchoolInfo(
          schulNm, dotenv.env['SCHOOL_API_KEY']!, 'json', 1, 100));
}
