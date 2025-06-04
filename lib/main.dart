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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  setFireBase();

  // .env 불러오기
  await dotenv.load(fileName: ".env");

  // GetIt DI 모듈 초기화
  setupDataSourceLocator();
  setupRepositoryLocator();
  setupApiLocator();
  setUpDio();
  setUpStorage();

  // 가로모드 방지
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android용 아이콘 밝기
      statusBarBrightness: Brightness.dark, // iOS에서 아이콘을 밝게 보이게 하려면 dark로 설정
    ),
  );

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
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                scaffoldBackgroundColor: GogoColors.black,
              ),
              routerDelegate: PageRouter.router.routerDelegate,
              routeInformationParser: PageRouter.router.routeInformationParser,
              routeInformationProvider:
                  PageRouter.router.routeInformationProvider,
              builder: (context, child) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: child!,
                );
              },
            ));
  }
}

void setFireBase() async {
  // Firebase 초기화

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FCM 백그라운드 메시지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FCM 포그라운드 푸시 알림 처리
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("포그라운드 알림: ${message.notification?.title}");
  });
}

@pragma('vm:entry-point') // 앱의 진입점 설정
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('🔔 FCM-Background ${message.messageId}');
}
