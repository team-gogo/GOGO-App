import '../../../data/models/stage/search_stage/search_stage_response.dart';

class StageState {}

class StageInitial extends StageState {}

class StageLoading extends StageState {}

class StageLoaded extends StageState {
  final SearchStageResponse stage;

  StageLoaded({required this.stage});
}

class StageError extends StageState {
  final String message;

  StageError({required this.message});
}
