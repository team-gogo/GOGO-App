import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import '../../../data/models/common/match_dto.dart';
import '../../../data/models/stage/search_stage/search_my_point_response.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();
  final MiniGameRepository _miniGameRepository =
      GetIt.instance<MiniGameRepository>();

  final int stageId;
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  List<MatchDto> matches = [];

  HomeBloc({required this.stageId}) : super(InitialHomeState()) {
    on<LoadHome>(_onLoadHome);
    on<LoadMatchesByDate>(_onLoadMatchesByDate);
    add(LoadMatchesByDate(selectedDate));
  }

  Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());
    try {
      final pointResponse = await _stageRepository.getMyPoint(stageId);
      final point = SearchMyPointResponse(point: pointResponse.point);

      final rankingResponse =
          await _stageRepository.searchRanking(stageId, 0, 5);
      final ranking = rankingResponse.rank;

      final postsResponse =
          await _stageRepository.getCommunityPosts(stageId, 0, 5, null, null);
      final communityPosts = postsResponse.board;

      final activeGameResponse =
          await _miniGameRepository.getActiveGame(stageId);
      emit(LoadedHomeState(
          communityPosts: communityPosts,
          ranking: ranking,
          points: point,
          activeGameResponse: activeGameResponse));
    } catch (e) {
      log(e.toString(), name: 'HomeBloc');
      emit(ErrorHomeState());
    }
  }

  Future<void> _onLoadMatchesByDate(
      LoadMatchesByDate event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingMatchHomeState());
      selectedDate = event.selectedDate;
      final matchesResponse = await _stageRepository.searchMatch(
          stageId, selectedDate.year, selectedDate.month, selectedDate.day);
      matches = matchesResponse.matches;
      add(LoadHome());
    } catch (e) {
      print(e);
      emit(ErrorHomeState());
    }
  }
}
