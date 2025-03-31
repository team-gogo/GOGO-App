import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/auth/sign_in/login_response.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_event.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository = GetIt.instance.get<AuthRepository>();
  final FlutterSecureStorage _storage =
      GetIt.instance.get<FlutterSecureStorage>();
  static final String _authority = 'authority';

  SplashBloc() : super(InitSplashState()) {
    on<LaunchSplashEvent>((event, emit) async {
      emit(AutoLoginLoading());
      try {
        await _authRepository.tokenRefresh();
        final String? authority = await _storage.read(key: _authority);
        log(authority ?? "authority is null");
        if (authority != Authority.UNAUTHENTICATED.toString() &&
            authority != null) {
          emit(AutoLoginSuccess());
          return;
        } else {
          emit(AutoLoginFailed());
        }
      } catch (e) {
        log("토큰 갱신 실패: $e");
        emit(AutoLoginFailed());
      }
    });
  }
}
