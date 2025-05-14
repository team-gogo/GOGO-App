// router.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/presentation/community/screen/community_main_screen.dart';
import 'package:gogo_app/presentation/community/screen/community_write_screen.dart';
import 'package:gogo_app/presentation/home/screen/home_screen.dart';
import 'package:gogo_app/presentation/logIn/screen/login_screen.dart';
import 'package:gogo_app/presentation/match_list/screen/match_list_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/coin_toss_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/minigame_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/yavarwee_screen.dart';
import 'package:gogo_app/presentation/navigation_view/widgets/bottom_navigation_bar/gogo_bottom_navigation_bar.dart';
import 'package:gogo_app/presentation/profile/screen/edit_profile_screen.dart';
import 'package:gogo_app/presentation/profile/screen/profile_screen.dart';
import 'package:gogo_app/presentation/ranking/screens/ranking_page.dart';
import 'package:gogo_app/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:gogo_app/presentation/splash/screen/splash_screen.dart';
import 'package:gogo_app/presentation/stage/screen/stage_screen.dart';
import 'package:gogo_app/presentation/stage_create/screen/stage_create_screen.dart';
import 'design_system/theme/color.dart';

class PageRouter {
  static final PageRouter _pageRouter = PageRouter.init();

  PageRouter.init();

  factory PageRouter() => _pageRouter;

  static const String splash = "splash";
  static const String login = "login";
  static const String signUp = "signUp";
  static const String home = "home";
  static const String stage = "stage";
  static const String alert = "alert";
  static const String profile = "profile";
  static const String editProfile = "editProfile";
  static const String createStage = "createStage";
  static const String miniGame = "miniGame";
  static const String coinToss = "coinToss";
  static const String yavarwee = "yavarwee";
  static const String ranking = "ranking";
  static const String community = "community";
  static const String communityWrite = "communityWrite";
  static const String matchList = "matchList";

  static GoRoute _customGoRoute({
    required String name,
    required Widget screen,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      name: name,
      path: "/$name",
      routes: routes,
      pageBuilder: (context, state) => CupertinoPage(
        child: screen,
      ),
    );
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
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) => Scaffold(
          backgroundColor: GogoColors.black,
          body: SafeArea(bottom: false, child: navigationShell),
          bottomNavigationBar: GogoBottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              if (index == navigationShell.currentIndex) {
                if (_.canPop()) {
                  _.pop();
                }
              } else {
                navigationShell.goBranch(index);
              }
            },
          ),
        ),
        branches: [
          StatefulShellBranch(routes: [
            _customGoRoute(name: home, screen: HomeScreen(stageId: 1,), routes: [
              _customGoRoute(name: miniGame, screen: MinigameScreen())
            ])
          ]),
          StatefulShellBranch(
              routes: [_customGoRoute(name: stage, screen: StageScreen())]),
          StatefulShellBranch(
              routes: [_customGoRoute(name: alert, screen: Placeholder())]),
          StatefulShellBranch(
              routes: [_customGoRoute(name: profile, screen: ProfileScreen())]),
        ],
      ),
      _customGoRoute(name: editProfile, screen: EditProfilePage()),
      _customGoRoute(name: createStage, screen: StageCreateScreen()),
      _customGoRoute(name: coinToss, screen: CoinTossScreen()),
      _customGoRoute(name: yavarwee, screen: YavarweeScreen()),
      _customGoRoute(name: ranking, screen: RankingPage()),
      _customGoRoute(name: matchList, screen: MatchListScreen()),
      _customGoRoute(
        name: community,
        screen: CommunityMainScreen(stageId: 1,),
        routes: [
          _customGoRoute(name: communityWrite, screen: CommunityWriteScreen(stageId: 1, ))
        ],
      )
    ],
  );
}
