import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/router.dart';
import 'data/get_it_module/get_it_module.dart';
import 'design_system/theme/color.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 스크린 이미지 불러오기
  await ScreenUtil.ensureScreenSize();
  // env 불러오기
  await dotenv.load(fileName: ".env");
  // 파이어베이스 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // get it dataSource Module 초기화
  setupDataSourceLocator();

  // get it repository Module 초기화
  setupRepositoryLocator();

  // get it api Module 초기화
  setupApiLocator();

  // get it api Module 초기화
  setUpDio();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
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
