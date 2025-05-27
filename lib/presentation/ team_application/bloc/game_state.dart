import '../../../data/models/stage/search_stage/search_game_response.dart';

sealed class GameState {}

final class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final SearchGameResponse gameItem;

  GameLoaded({required this.gameItem});
}

class GameError extends GameState {
  final String message;

  GameError({required this.message});
}
