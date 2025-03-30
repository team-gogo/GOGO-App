import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../data_sources/token_data_source/token_data_source.dart';

class AuthTokenInterceptor extends Interceptor {
  final List<String> excludedPaths = [
    '/user/auth/login',
    '/user/auth/refresh',
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!excludedPaths.contains(options.path)) {
      final tokenDataSource = GetIt.instance<TokenDataSource>();
      final accessToken = await tokenDataSource.getAccessToken();

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    super.onRequest(options, handler);
  }
}