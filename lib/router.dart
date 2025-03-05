import 'package:go_router/go_router.dart';
import 'package:gogo_app/presentation/logIn/screen/login_screen.dart';
import 'package:gogo_app/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';

class PageRouter {
  static final PageRouter _pageRouter = PageRouter.init();

  PageRouter.init();

  factory PageRouter() => _pageRouter;

  static const String splash = "splash";
  static const String login = "login";
  static const String signUp = "signUp";

  static GoRoute _customGoRoute(
    String name,
    Widget screen,
  ) {
    return GoRoute(
      name: name,
      path: "/$name",
      pageBuilder: (context, state) {
        return CupertinoPage(
          child: screen,
        );
      },
    );
  }

  static final router = GoRouter(
    initialLocation: "/$splash",
    routes: [
      _customGoRoute(splash, LogInScreen()),
      _customGoRoute(login, LogInScreen()),
      _customGoRoute(signUp, SignUpScreen()),
    ],
  );
}
