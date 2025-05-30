import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/presentation/community/screen/community_main_screen.dart';
import 'package:gogo_app/presentation/community/screen/community_write_screen.dart';
import 'package:gogo_app/presentation/home/screen/home_screen.dart';
import 'package:gogo_app/presentation/loading/screens/join_stage_page.dart';
import 'package:gogo_app/presentation/logIn/screen/login_screen.dart';
import 'package:gogo_app/presentation/match_detail/screen/match_detail_screen.dart';
import 'package:gogo_app/presentation/match_list/screen/match_list_screen.dart';
import 'package:gogo_app/presentation/match_team_info/screens/match_team_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/coin_toss_screen.dart';
import 'package:gogo_app/presentation/minigame/screen/minigame_screen.dart';
import 'package:gogo_app/presentation/profile/screen/edit_profile_screen.dart';
import 'package:gogo_app/presentation/profile/screen/profile_screen.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_bloc.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_event.dart';
import 'package:gogo_app/presentation/ranking/screens/ranking_page.dart';
import 'package:gogo_app/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:gogo_app/presentation/splash/screen/splash_screen.dart';
import 'package:gogo_app/presentation/stage/screen/stage_screen.dart';
import 'package:gogo_app/presentation/stage_create/screen/stage_create_screen.dart';
import 'package:gogo_app/presentation/team_application/screen/team_application_screen.dart';
import 'package:gogo_app/presentation/team_confirmed/screen/team_confirmed_screen.dart';

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
  static const String matchDetail = "matchDetail";
  static const String matchTeamInfo = "matchTeamInfo";
  static const String teamApplication = 'teamApplication';
  static const String createTeam = "createTeam";
  static const String teamConfirmed = "teamConfirmed";

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

  static Future gogoPushNamed(String name, int stageId) =>
      router.pushNamed(name, queryParameters: {'stageId': stageId.toString()});

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
      _customGoRoute(
        name: stage,
        screen: StageScreen(),
        routes: [
          GoRoute(
            name: teamConfirmed,
            path: '$teamConfirmed',
            pageBuilder: (context, state) {
              final stageId =
              int.parse(state.uri.queryParameters['stageId']!);
              final gameId =
              int.parse(state.uri.queryParameters['gameId']!);
              return CupertinoPage(
                child: TeamConfirmedScreen(
                  stageId: stageId,
                  gameId: gameId,
                ),
              );
            },
          ),
          GoRoute(
              name: teamApplication,
              path: '/$teamApplication',
              pageBuilder: (context, state) {
                final stageId =
                    int.parse(state.uri.queryParameters['stageId']!);
                final isMaintainer =
                    bool.parse(state.uri.queryParameters['isMaintainer']!);
                return CupertinoPage(
                  child: TeamApplicationScreen(
                    stageId: stageId,
                    isManger: isMaintainer,
                  ),
                );
              },
              ),
          GoRoute(
            name: home,
            path: "/$home",
            pageBuilder: (context, state) {
              final stageIdRaw = state.uri.queryParameters['stageId'];
              final stageId = int.tryParse(stageIdRaw ?? '');
              return CupertinoPage(
                child: stageId == null
                    ? JoinStagePage()
                    : HomeScreen(stageId: stageId),
              );
            },
            routes: [
              GoRoute(
                name: ranking,
                path: '$ranking',
                pageBuilder: (context, state) {
                  final stageId =
                      int.parse(state.uri.queryParameters['stageId']!);
                  return CupertinoPage(
                      child: BlocProvider(
                    create: (_) =>
                        RankingBloc()..add(GetRanking(stageId: stageId)),
                    child: RankingPage(stageId: stageId),
                  ));
                },
              ),
              GoRoute(
                name: community,
                path: '$community',
                pageBuilder: (context, state) {
                  final stageId =
                      int.parse(state.uri.queryParameters['stageId']!);
                  return CupertinoPage(
                      child: CommunityMainScreen(stageId: stageId));
                },
                routes: [
                  GoRoute(
                    name: communityWrite,
                    path: '$communityWrite',
                    pageBuilder: (context, state) {
                      final stageId =
                          int.parse(state.uri.queryParameters['stageId']!);
                      final List<GameType> gameTypeList =
                          state.extra as List<GameType>;
                      return CupertinoPage(
                        child: CommunityWriteScreen(
                          stageId: stageId,
                          gameTypeList: gameTypeList,
                        ),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                name: miniGame,
                path: '$miniGame',
                pageBuilder: (context, state) {
                  final stageId = int.parse(state.uri.queryParameters['stageId']!);
                  return CupertinoPage(
                    child: MinigameScreen(stageId: stageId),
                  );
                },
              ),
              _customGoRoute(name: matchList, screen: MatchListScreen()),
              GoRoute(
                name: matchTeamInfo,
                path: '$matchTeamInfo',
                pageBuilder: (context, state) {
                  final stageId =
                      int.parse(state.uri.queryParameters['stageId']!);
                  final gameIndex =
                      int.parse(state.uri.queryParameters['gameIndex'] ?? '0');
                  return CupertinoPage(
                      child: MatchTeamInfoScreen(
                          stageId: stageId, gameIndex: gameIndex));
                },
              ),
            ],
          ),
          GoRoute(
            name: matchDetail,
            path: '/$matchDetail/:matchId',
            pageBuilder: (context, state) {
              final matchId = int.parse(state.pathParameters['matchId']!);
              final MatchDto matchDto = state.extra as MatchDto;
              return CustomTransitionPage(
                transitionDuration: Duration(milliseconds: 300),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: MatchDetailScreen(
                  matchDto: matchDto,
                  matchId: matchId,
                ),
              );
            },
          ),
        ],
      ),
      _customGoRoute(name: PageRouter.alert, screen: Placeholder()),
      _customGoRoute(
          name: PageRouter.profile,
          screen: ProfileScreen(),
          routes: [
            GoRoute(
              name: PageRouter.editProfile,
              path: "/${PageRouter.editProfile}",
              pageBuilder: (context, state) {
                final userInfo = state.extra as UserInfoResponse;
                return CupertinoPage(
                  child: EditProfilePage(userInfo: userInfo),
                );
              },
            ),
          ]),
      _customGoRoute(name: createStage, screen: StageCreateScreen()),
    ],
  );
}
