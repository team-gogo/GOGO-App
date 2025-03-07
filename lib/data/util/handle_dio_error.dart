import 'package:dio/dio.dart';

Exception handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return Exception('서버 연결 시간 초과!');
    case DioExceptionType.sendTimeout:
      return Exception('요청 전송 시간 초과!');
    case DioExceptionType.receiveTimeout:
      return Exception('응답 수신 시간 초과!');
    case DioExceptionType.badResponse:
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            return Exception('잘못된 요청입니다. 요청을 다시 확인해주세요.');
          case 401:
            return Exception('인증 실패! 로그인 정보가 유효하지 않습니다.');
          case 403:
            return Exception('접근이 거부되었습니다. 권한을 확인해주세요.');
          case 404:
            return Exception('요청한 리소스를 찾을 수 없습니다.');
          case 500:
            return Exception('서버 내부 오류가 발생했습니다.');
          default:
            return Exception('알 수 없는 서버 오류 (${e.response!.statusCode})');
        }
      }
      return Exception('잘못된 요청입니다.');
    case DioExceptionType.cancel:
      return Exception('요청이 취소되었습니다!');
    case DioExceptionType.connectionError:
      return Exception('네트워크 연결 오류! 인터넷 연결을 확인하세요.');
    default:
      return Exception('알 수 없는 오류 발생!');
  }
}
