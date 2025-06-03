import '../../../data/models/mini_game/active_game_response.dart';
import '../../../data/models/mini_game/bet_limit_response.dart';
import '../../../data/models/stage/community/search_board_response.dart';
import '../../../data/models/stage/search_stage/search_game_response.dart';
import '../../../data/models/stage/search_stage/search_my_point_response.dart';
import '../../../data/models/stage/search_stage/search_ranking_response.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingMatchHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  bool isBankruptcy = false;
  List<Board> communityPosts = [];
  List<Rank> ranking = [];
  SearchMyPointResponse points = SearchMyPointResponse(point: 0);
  ActiveGameResponse activeGameResponse = ActiveGameResponse(
      isPlinkoActive: false, isCoinTossActive: false, isYavarweeActive: false);
  SearchGameResponse gameResponse;
  BetLimitResponse? betLimitResponse;

  LoadedHomeState({
    this.isBankruptcy = false,
    required this.communityPosts,
    required this.ranking,
    required this.points,
    required this.activeGameResponse,
    required this.gameResponse,
    this.betLimitResponse,
  });
}

class ErrorHomeState extends HomeState {}

class BetLimitLoading extends HomeState {}

class BetLimitLoaded extends HomeState {
  final BetLimitResponse betLimitResponse;

  BetLimitLoaded({required this.betLimitResponse});
}

class BetLimitError extends HomeState {
  final String message;

  BetLimitError({required this.message});
}
