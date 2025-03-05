import 'package:flutter/material.dart';
import 'package:gogo_app/core/design_system/theme/color.dart';
import 'package:gogo_app/router.dart';

void main() {
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
