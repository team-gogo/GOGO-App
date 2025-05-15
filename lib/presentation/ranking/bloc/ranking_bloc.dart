import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_event.dart';
import 'package:gogo_app/presentation/ranking/bloc/ranking_state.dart';
import 'package:stream_transform/stream_transform.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final StageRepository _rankingRepository = GetIt.instance<StageRepository>();

  RankingBloc() : super(RankingState()) {
    on<GetRanking>(_getRankingEventHandler,
        transformer: throttleDroppable(throttleDuration));
  }

  int currentPage = 0;

  void _getRankingEventHandler(
      GetRanking event, Emitter<RankingState> emit) async {
    if (state.hasReachedMax) return;
    try {
      final response = await _rankingRepository.searchRanking(
          event.stageId, currentPage, _postLimit);
      currentPage++;

      if (response.rank.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      emit(
        state.copyWith(
          status: RankingStatus.loaded,
          rank: [...state.rank, ...response.rank],
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(
        status: RankingStatus.error,
      ));
    }
  }
}
