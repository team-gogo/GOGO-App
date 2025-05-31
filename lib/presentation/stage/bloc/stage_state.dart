import '../../../data/models/stage/search_stage/search_stage_response.dart';
import '../../../data/models/mini_game/betting/bet_limit_response.dart';

class StageState {}

class StageInitial extends StageState {}

class StageLoading extends StageState {}

class StageLoaded extends StageState {
  final SearchStageResponse stage;
  final BetLimitResponse? betLimitResponse;

  StageLoaded({required this.stage, this.betLimitResponse});
}

class StageError extends StageState {
  final String message;

  StageError({required this.message});
}
