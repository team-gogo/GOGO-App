import 'package:gogo_app/data/models/auth/user_info/user_info_request.dart';

abstract class ProfileEvent {}

class FetchMyProfile extends ProfileEvent {}

class EditProfile extends ProfileEvent {
  final UserInfoRequest user;

  EditProfile({required this.user});
}