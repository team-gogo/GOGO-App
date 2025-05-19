import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_event.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState> {
    final AuthRepository repository = GetIt.instance<AuthRepository>();

    ProfileBloc() : super(UserInfoLoadingState()) {
    on<FetchUserInfo>(_onFetchUserInfo);
  }

  Future<void> _onFetchUserInfo (FetchUserInfo event, Emitter<ProfileState> emit) async {
    try {
        emit(UserInfoLoadingState());
        final response = await repository.getUserInfo();
        emit(UserInfoLoadedState(response: response));
    } catch(e) {
        emit(UserInfoErrorState(message: e.toString()));
    }
  }
}