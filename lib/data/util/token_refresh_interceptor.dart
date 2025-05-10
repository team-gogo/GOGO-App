import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import '../data_sources/token_data_source/token_data_source.dart';
import '../models/auth/google_oauth/token_dto.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Dio _interceptorDio = Dio();
  final TokenDataSource _tokenDataSource = GetIt.instance.get<TokenDataSource>();
  int _retryCount = 0;

  TokenRefreshInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && _retryCount < 3) {
      _retryCount++;
      try {

        final refreshToken = await _tokenDataSource.getRefreshToken();
        final newToken = await _interceptorDio.post('${dotenv.env['BASE_URL']}/user/auth/refresh',);
        final tokenDto = TokenDto.fromJson(newToken.data);
        
        if (refreshToken != null && refreshToken.isNotEmpty) {
          _interceptorDio.options.headers['Authorization'] = 'Bearer ${tokenDto.accessToken}';

          _tokenDataSource.saveToken(tokenDto);

          final response = await _interceptorDio.request(
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