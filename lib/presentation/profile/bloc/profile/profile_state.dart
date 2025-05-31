import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';

abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserInfoResponse userInfoResponse;
  final SearchStageResponse searchStageResponse;
  ProfileLoadedState({required this.userInfoResponse, required this.searchStageResponse});
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}
