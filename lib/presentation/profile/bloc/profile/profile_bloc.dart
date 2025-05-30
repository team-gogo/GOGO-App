import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_event.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository = GetIt.instance<AuthRepository>();
  final StageRepository stageRepository = GetIt.instance<StageRepository>();

  ProfileBloc() : super(ProfileLoadingState()) {
    on<FetchMyProfile>(_onFetchMyProfile);
    on<LogoutProfile>(_logoutProfile);
    on<WithdrawProfile>(_withdrawProfile);
  }

  Future<void> _onFetchMyProfile(
      FetchMyProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      final userInfoResponse = await authRepository.getUserInfo();
      final myStageResponse = await stageRepository.getAllStages();
      emit(ProfileLoadedState(
          userInfoResponse: userInfoResponse,
          searchStageResponse: myStageResponse));
    } catch (e) {
      emit(ProfileErrorState(message: e.toString()));
    }
  }

  Future<void> _logoutProfile(
      LogoutProfile event, Emitter<ProfileState> emit) async {
    try {
      await authRepository.logOut();
    } catch (e) {
      emit(ProfileErrorState(message: e.toString()));
    }
  }

  Future<void> _withdrawProfile(
      WithdrawProfile event, Emitter<ProfileState> emit) async {
    try {
      await authRepository.logOut();
    } catch (e) {
      emit(ProfileErrorState(message: e.toString()));
    }
  }
}
