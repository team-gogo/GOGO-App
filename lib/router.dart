// router.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/presentation/community/screen/community_main_screen.dart';
import 'package:gogo_app/presentation/community/screen/community_write_screen.dart';
import 'package:gogo_app/presentation/home/screen/home_screen.dart';
import 'package:gogo_app/presentation/loading/join_stage_page.dart';
import 'package:gogo_app/presentation/logIn/screen/login_screen.dart';
import 'package:gogo_app/presentation/match_list/screen/match_list_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/coin_toss_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/minigame_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/yavarwee_screen.dart';
import 'package:gogo_app/presentation/navigation_view/widgets/bottom_navigation_bar/gogo_bottom_navigation_bar.dart';
import 'package:gogo_app/presentation/profile/screen/edit_profile_screen.dart';
import 'package:gogo_app/presentation/profile/screen/profile_screen.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_bloc.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_event.dart';
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
            GoRoute(
                path: "/$home",
                pageBuilder: (context, state) => CupertinoPage(
                      child: JoinStagePage(),
                    ),
                routes: [
                  GoRoute(
                      name: home,
                      path: '/:stageId',
                      pageBuilder: (context, state) => CupertinoPage(
                            child: HomeScreen(
                              stageId: int.parse(
                                state.pathParameters['stageId']!.isEmpty
                                    ? '0'
                                    : state.pathParameters['stageId']!,
                              ),
                            ),
                          ),
                      routes: [
                        GoRoute(
                            name: ranking,
                            path: ranking,
                            pageBuilder: (context, state) {
                              final stageId =
                                  int.parse(state.pathParameters['stageId']!);
                              return CupertinoPage(
                                  child: BlocProvider(
                                create: (_) => RankingBloc()
                                  ..add(GetRanking(stageId: stageId)),
                                child: RankingPage(stageId: stageId),
                              ));
                            }),
                        GoRoute(
                            name: community,
                            path: community,
                            pageBuilder: (context, state) {
                              final stageId =
                                  int.parse(state.pathParameters['stageId']!);
                              return CupertinoPage(
                                  child: CommunityMainScreen(stageId: stageId));
                            },
                            routes: [
                              GoRoute(
                                name: communityWrite,
                                path: communityWrite,
                                pageBuilder: (context, state) {
                                  final stageId = int.parse(
                                      state.pathParameters['stageId']!);
                                  final List<GameType> gameTypeList =
                                      state.extra as List<GameType>;
                                  return CupertinoPage(
                                      child: CommunityWriteScreen(
                                    stageId: stageId,
                                    gameTypeList: gameTypeList,
                                  ));
                                },
                              ),
                            ]),
                        _customGoRoute(
                            name: coinToss, screen: CoinTossScreen()),
                        _customGoRoute(
                            name: yavarwee, screen: YavarweeScreen()),
                        _customGoRoute(
                            name: matchList, screen: MatchListScreen()),
                        _customGoRoute(
                            name: miniGame, screen: MinigameScreen()),
                      ])
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
    ],
  );
}
