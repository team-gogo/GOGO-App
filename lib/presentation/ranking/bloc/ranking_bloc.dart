import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_state.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_event.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_state.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/models/stage/search_stage/search_ranking_response.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final StageRepository _rankingRepository = GetIt.instance<StageRepository>();

  RankingBloc() : super(InitRanking()) {
    on<GetRanking>(_getRankingEventHandler,
        transformer: throttleDroppable(throttleDuration));
  }

  int currentPage = 0;
  List<Rank> rank = [];
  bool hasReachedMax = false;

  void _getRankingEventHandler(
      GetRanking event, Emitter<RankingState> emit) async {
    if (hasReachedMax) return;
    try {
      if (event.isRefresh) {
        emit(InitRanking());
        currentPage = 0;
        rank.clear();
        hasReachedMax = false;
      }
      final response = await _rankingRepository.searchRanking(
          event.stageId, currentPage, _postLimit);
      if (response.rank.isEmpty) {
        hasReachedMax = true;
        return;
      }
      currentPage++;
      rank.addAll(response.rank);
      emit(LoadedRanking());
    } catch (e) {
      print(e);
      emit(ErrorRanking());
    }
  }
}
