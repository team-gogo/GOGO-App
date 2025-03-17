import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import '../data_sources/token_data_source/token_data_source.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Dio dio = GetIt.instance.get<Dio>();
  final TokenDataSource _tokenDataSource = GetIt.instance.get<TokenDataSource>();
  final AuthRepository _authRepository = GetIt.instance.get<AuthRepository>();
  int _retryCount = 0;

  TokenRefreshInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && _retryCount < 3) {
      _retryCount++;
      try {
        final newToken = await _authRepository.tokenRefresh();

        if (newToken.accessToken.isNotEmpty) {
          dio.options.headers['Authorization'] = 'Bearer ${newToken.accessToken}';

          _tokenDataSource.saveToken(newToken);

          final response = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
          );

          _retryCount = 0;
          return handler.resolve(response);
        } else {
          return handler.next(DioException(requestOptions: err.requestOptions, error: 'Failed to refresh token'));
        }
      } catch (e) {
        return handler.next(DioException(requestOptions: err.requestOptions, error: e.toString()));
      }
    }
    return handler.next(err);
  }
}