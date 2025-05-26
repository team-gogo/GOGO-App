import '../../../data/models/mini_game/active_game_response.dart';
import '../../../data/models/stage/community/search_board_response.dart';
import '../../../data/models/stage/search_stage/search_game_response.dart';
import '../../../data/models/stage/search_stage/search_my_point_response.dart';
import '../../../data/models/stage/search_stage/search_ranking_response.dart';
import '../../../data/models/stage/search_stage/search_team_response.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingMatchHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  List<Board> communityPosts = [];
  List<Rank> ranking = [];
  SearchMyPointResponse points = SearchMyPointResponse(point: 0);
  ActiveGameResponse activeGameResponse = ActiveGameResponse(
      isPlinkoActive: false, isCoinTossActive: false, isYavarweeActive: false);
  SearchGameResponse gameResponse;

  LoadedHomeState({
    required this.communityPosts,
    required this.ranking,
    required this.points,
    required this.activeGameResponse,
    required this.gameResponse,
  });
}

class ErrorHomeState extends HomeState {}
