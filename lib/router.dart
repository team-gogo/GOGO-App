import 'package:go_router/go_router.dart';
import 'package:gogo_app/presentation/logIn/screen/login_screen.dart';
import 'package:gogo_app/presentation/sign_up/widgets/page/sex_page.dart';

class PageRouter {
  static final PageRouter _pageRouter = PageRouter.init();

  PageRouter.init();

  factory PageRouter() => _pageRouter;

  static const String splash = "splash";
  static const String login = "login";

  static final router = GoRouter(
    initialLocation: "/$splash",
    routes: [
      GoRoute(
        name: splash,
        path: "/$splash",
        builder: (_, __) => /*splash screen 넣기 */ SexPage(),
      ),
      GoRoute(
        name: login,
        path: "/$login",
        builder: (_, __) => LogInScreen(),
      ),
    ],
  );
}
