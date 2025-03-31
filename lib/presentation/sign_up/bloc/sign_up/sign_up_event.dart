import '../../../../data/models/auth/additional_sign_up/additional_sign_up_response.dart';

abstract class SignUpEvent {}

class AdditionalSignUpRequestEvent extends SignUpEvent {
  final AdditionalSignUpRequest additionalSignUpRequest;

  AdditionalSignUpRequestEvent(this.additionalSignUpRequest);
}
