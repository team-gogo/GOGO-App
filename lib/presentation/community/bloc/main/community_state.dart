import 'package:gogo_app/data/models/stage/community/search_board_response.dart';

abstract class CommunityState {}

class CommunityLoadingState extends CommunityState {}

class CommunityLoadedState extends CommunityState {
  final SearchBoardResponse response;

  CommunityLoadedState({required this.response});
}

class CommunityErrorState extends CommunityState {
  final String message;

  CommunityErrorState({required this.message});
}
