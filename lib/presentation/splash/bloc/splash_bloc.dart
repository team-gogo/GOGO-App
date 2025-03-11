import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_event.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_state.dart';
import 'package:gogo_app/router.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  late String deviceToken;

  SplashBloc() : super(InitSplashState()) {
    on<LaunchSplashEvent>((event, emit) async {
      emit(LoadingSplashState());
      deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
      await Future.delayed(Duration(seconds: 2));
      emit(DisposeSplashState());
    });
  }
}

