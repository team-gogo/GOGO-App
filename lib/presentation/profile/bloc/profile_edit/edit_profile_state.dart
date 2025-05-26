abstract class EditProfileState {}

class DisableUserInfoState extends EditProfileState {}

class EnableUserInfoState extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String error;

  EditProfileFailure(this.error);
}