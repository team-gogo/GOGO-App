import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gogo_app/core/design_system/theme/color.dart';
import 'package:gogo_app/router.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
