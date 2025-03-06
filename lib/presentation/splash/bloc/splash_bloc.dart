import 'package:bloc/bloc.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_event.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_state.dart';
import 'package:gogo_app/router.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitSplashState()) {
    on<LaunchSplashEvent>((event, emit) async {
      emit(LoadingSplashState());
      await Future.delayed(Duration(seconds: 2));

      emit(DisposeSplashState());
      PageRouter.router.goNamed(PageRouter.login);
    });
  }
}
