import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';

abstract class EditProfileEvent {}

class EnterUserInfoEvent extends EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  final bool isFiltered;

  UpdateProfileEvent({required this.isFiltered});
}

class UpdateSexEvent extends EditProfileEvent {
  final Sex sex;

  UpdateSexEvent({required this.sex});
}