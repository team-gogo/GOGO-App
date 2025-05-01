import 'package:gogo_app/data/models/stage/community/community_like_response.dart';
import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';

abstract class CommunityDetailState {}

class CommunityDetailLoadingState extends CommunityDetailState {}

class CommunityDetailLoadedState extends CommunityDetailState {
  final SearchCommunityDetailResponse response;

  CommunityDetailLoadedState({required this.response});
}

class CommunityDetailPostLoadedState extends CommunityDetailState {
  final CommunityLikeResponse response;

  CommunityDetailPostLoadedState({required this.response});
}

class CommunityDetailErrorState extends CommunityDetailState {
  final String message;

  CommunityDetailErrorState({required this.message});
}