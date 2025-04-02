import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import '../../../data/models/common/match_dto.dart';
import '../../../data/models/stage/community/search_board_response.dart';
import '../../../data/models/stage/search_stage/search_my_point_response.dart';
import '../../../data/models/stage/search_stage/search_ranking_response.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  final int stageId;
  bool isLoading = false;
  SearchMyPointResponse points = SearchMyPointResponse(point: 0);
  List<Board> communityPosts = [];
  List<Rank> ranking = [];
  List<MatchDto> matches = [];
  DateTime selectedDate = DateTime.now();
  String errorMessage = '';

  HomeBloc({required this.stageId}) : super(InitialHomeState()) {
    on<LoadHome>(_onLoadHome);
    on<LoadMatchesByDate>(_onLoadMatchesByDate);

    add(LoadHome());
    add(LoadMatchesByDate(selectedDate));
  }

  Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());
    try {
      final point = await _stageRepository.getMyPoint(stageId);
      points = SearchMyPointResponse(point: point.point);

      final rankingResponse =
          await _stageRepository.searchRanking(stageId, 1, 5);
      ranking = rankingResponse.rank;

      final postsResponse =
          await _stageRepository.getCommunityPosts(stageId, 1, 5, null, null);
      communityPosts = postsResponse.board;
    } catch (e) {
      emit(ErrorHomeState());
    }
  }

  Future<void> _onLoadMatchesByDate(
      LoadMatchesByDate event, Emitter<HomeState> emit) async {
    emit(LoadingMatchHomeState());
    try {
      final matchesResponse = await _stageRepository.searchMatch(
          stageId, selectedDate.year, selectedDate.month, selectedDate.day);
      matches = matchesResponse.matches;
    } catch (e) {
      emit(ErrorHomeState());
    }
  }
}
