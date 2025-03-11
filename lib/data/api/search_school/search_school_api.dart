import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/search_school/search_school_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'search_school_api.g.dart';

@RestApi(baseUrl: "https://open.neis.go.kr")
abstract class SearchSchoolApi {
  factory SearchSchoolApi(Dio dio, {String baseUrl}) = _SearchSchoolApi;

  @GET('/hub/schoolInfo')
  Future<SearchSchoolRowModel> getSchoolInfo(
    @Query("SCHUL_NM") String? schulNm,
    @Query("KEY") String key,
    @Query("type") String type,
    @Query("pIndex") int pIndex,
    @Query("pSize") int pSize,
  );
}
