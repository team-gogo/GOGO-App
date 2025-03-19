import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/router.dart';
import 'data/get_it_module/get_it_module.dart';
import 'design_system/theme/color.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FCM 백그라운드 메시지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // .env 불러오기
  await dotenv.load(fileName: ".env");

  // GetIt DI 모듈 초기화
  setupDataSourceLocator();
  setupRepositoryLocator();
  setupApiLocator();
  setUpDio();

  // 알림 권한 요청
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    carPlay: true,
    sound: true,
  );

  // 포그라운드 푸시 알림 처리
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("포그라운드 알림: ${message.notification?.title}");
  });

  // 가로모드 방지 (Firebase 초기화 후로 이동)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: GogoColors.black,
        ),
        routerDelegate: PageRouter.router.routerDelegate,
        routeInformationParser: PageRouter.router.routeInformationParser,
        routeInformationProvider: PageRouter.router.routeInformationProvider,
      ),
    );
  }
}
