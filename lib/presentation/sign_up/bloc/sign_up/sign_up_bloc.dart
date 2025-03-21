import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/presentation/sign_up/bloc/sign_up/sign_up_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/sign_up/sign_up_state.dart';

import 'package:gogo_app/data/repositories/auth/auth_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository = GetIt.instance<AuthRepository>();

  SignUpBloc() : super(InitialState()) {
    on<AdditionalSignUpRequestEvent>(_additionalSignUpRequestEventHandler);
  }

  void _additionalSignUpRequestEventHandler(
      AdditionalSignUpRequestEvent event, Emitter<SignUpState> emit) async {
    try {
      _authRepository.additionalSignUp(event.additionalSignUpRequest);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure());
    }
  }
}
