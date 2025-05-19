import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';

abstract class ProfileState {}

class UserInfoLoadingState extends ProfileState {}

class UserInfoLoadedState extends ProfileState {
  final UserInfoResponse response;

  UserInfoLoadedState({required this.response});
}

class UserInfoErrorState extends ProfileState {
  final String message;

  UserInfoErrorState({required this.message});
}