import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/stage/stage_repository.dart';
import 'match_info_event.dart';
import 'match_info_state.dart';
import 'package:get_it/get_it.dart';

class SearchMatchBloc extends Bloc<SearchMatchEvent, SearchMatchState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  final int stageId;

  SearchMatchBloc({required this.stageId}) : super(SearchMatchInitial()) {
    on<SearchMatchRequested>(_onSearchMatchRequested);
  }

  Future<void> _onSearchMatchRequested(
      SearchMatchRequested event,
      Emitter<SearchMatchState> emit,
      ) async {
    emit(SearchMatchLoading());
    try {
      final result = await _stageRepository.searchMatchInfo(event.matchId);
      emit(SearchMatchSuccess(matchInfo: result));
    } catch (e) {
      emit(SearchMatchFailure(message: e.toString()));
    }
  }
}
