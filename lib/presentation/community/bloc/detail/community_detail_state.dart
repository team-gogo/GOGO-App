import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';

abstract class CommunityDetailState {}

class CommunityDetailLoadingState extends CommunityDetailState {}

class CommunityDetailLoadedState extends CommunityDetailState {
  final SearchCommunityDetailResponse response;

  CommunityDetailLoadedState({required this.response});
}

class CommunityDetailErrorState extends CommunityDetailState {
  final String message;

  CommunityDetailErrorState({required this.message});
}