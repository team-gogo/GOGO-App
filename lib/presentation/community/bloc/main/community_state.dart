import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';

abstract class CommunityState {}

class CommunityLoadingState extends CommunityState {}

class CommunityLoadedState extends CommunityState {
  final SearchBoardResponse response;
  final List<GameType> gameTypes;

  CommunityLoadedState({required this.response, required this.gameTypes});
}

class CommunityErrorState extends CommunityState {
  final String message;

  CommunityErrorState({required this.message});
}
