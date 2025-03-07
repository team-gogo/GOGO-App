import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gogo_app/router.dart';
import 'data/get_it_module/get_it_module.dart';
import 'design_system/theme/color.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: GogoColors.black),
      routerConfig: PageRouter.router,
    );
  }
}
