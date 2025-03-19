import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_event.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository = GetIt.instance.get<AuthRepository>();

  SplashBloc() : super(InitSplashState()) {
    on<LaunchSplashEvent>((event, emit) async {
      emit(AutoLoginLoading());
      try {
        await _authRepository.tokenRefresh();
        emit(AutoLoginSuccess());
      } catch (e) {
        log("토큰 갱신 실패: $e");
        emit(AutoLoginFailed());
      }
    });
  }
}
