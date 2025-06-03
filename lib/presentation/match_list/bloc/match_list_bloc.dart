import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import '../../../data/repositories/betting/betting_repository.dart';
import '../../../data/repositories/stage/stage_repository.dart';
import 'match_list_event.dart';
import 'match_list_state.dart';
import '../../../data/models/common/match_dto.dart';

class MatchListBloc extends Bloc<MatchListEvent, MatchListState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();
  final BettingRepository _bettingRepository =
      GetIt.instance<BettingRepository>();

  final int stageId;
  final int year;
  final int month;
  final int day;
  GameType? gameType;

  MatchListBloc({
    required this.stageId,
    required this.year,
    required this.month,
    required this.day,
  }) : super(InitMatchList()) {
    on<LoadItems>(_onLoadItems);
    on<BettingMatch>(_onBettingMatch);
  }

  Future<void> _onLoadItems(
      LoadItems event, Emitter<MatchListState> emit) async {
    emit(LoadingMatchList());

    try {
      final matchesResponse = await _stageRepository.searchMatch(
        stageId,
        year,
        month,
        day,
      );
      List<MatchDto> filtered = matchesResponse.matches;

      if (event.gameType != null) {
        filtered =
            filtered.where((e) => event.gameType == event.gameType).toList();
      }
      if (event.sortOrder != null) {
        filtered.sort((a, b) {
          return event.sortOrder == SortOrder.ascending
              ? a.startDate.compareTo(b.startDate)
              : b.startDate.compareTo(a.startDate);
        });
      }

      emit(LoadedMatchList(matchList: filtered, hasReachedMax: true));
    } catch (e) {
      emit(InitMatchList());
    }
  }

  Future<void> _onBettingMatch(
      BettingMatch event, Emitter<MatchListState> emit) async {
    try {
      await _bettingRepository.bettingMatch(event.matchId, event.request);
      emit(BettingSuccess());
    } catch (e) {
      emit(BettingFailure(e.toString()));
    }
  }
}
