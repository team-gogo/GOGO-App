import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_event.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository = GetIt.instance.get<AuthRepository>();

  SplashBloc() : super(InitSplashState()) {
    on<LaunchSplashEvent>((event, emit) async {
      emit(LoadingSplashState());
      _settingPermission();
      deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
      print(deviceToken);
      await Future.delayed(Duration(seconds: 2));
      emit(DisposeSplashState());
    });
  }

  void _settingPermission() async {
    ///================================================================= 알림 권한 설정
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    ///================================================================= 포그라운드 알림 처리
    FirebaseMessaging.onMessage
        .listen((RemoteMessage message) => print(message.notification?.title));
  }
}
