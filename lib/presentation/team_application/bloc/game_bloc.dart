import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../data/models/stage/search_stage/search_game_response.dart';
import '../../../data/repositories/stage/stage_repository.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  GameBloc() : super(GameInitial()) {
    on<GetGameEvent>(_getGameEventHandler);
  }

  void _getGameEventHandler(GetGameEvent event, Emitter<GameState> emit) async {
    emit(GameLoading());
    try {
      SearchGameResponse game = await _stageRepository.getGame(event.stageId);
      emit(GameLoaded(gameItem: game));
    } catch (e) {
      emit(GameError(message: e.toString()));
    }
  }
}
