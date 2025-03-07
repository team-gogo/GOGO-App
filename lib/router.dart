import 'package:go_router/go_router.dart';
import 'package:gogo_app/presentation/logIn/screen/login_screen.dart';
import 'package:gogo_app/presentation/navigationView/screen/navigation_view.dart';
import 'package:gogo_app/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogo_app/presentation/splash/screen/splash_screen.dart';

class PageRouter {
  static final PageRouter _pageRouter = PageRouter.init();

  PageRouter.init();

  factory PageRouter() => _pageRouter;

  static const String splash = "splash";
  static const String login = "login";
  static const String signUp = "signUp";
  static const String main = "main";

  static GoRoute _customGoRoute({
    required String name,
    required Widget screen,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
        name: name, path: "/$name", routes: routes, builder: (_, __) => screen);
  }

  static final router = GoRouter(
    initialLocation: "/$splash",
    routes: [
      _customGoRoute(name: splash, screen: SplashScreen()),
      GoRoute(
        name: login,
        path: "/$login",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: LogInScreen(),
          );
        },
      ),
      _customGoRoute(name: signUp, screen: SignUpScreen()),
      _customGoRoute(name: main, screen: NavigationView())

    ],
  );
}
