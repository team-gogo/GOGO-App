import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import '../../../data/models/common/match_dto.dart';
import '../../../data/models/stage/search_stage/search_my_point_response.dart';
import '../../../data/models/stage/search_stage/search_team_response.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();
  final MiniGameRepository _miniGameRepository =
      GetIt.instance<MiniGameRepository>();
  final FlutterSecureStorage _storage =
      GetIt.instance.get<FlutterSecureStorage>();

  final int stageId;
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  List<MatchDto> matches = [];

  HomeBloc({required this.stageId}) : super(InitialHomeState()) {
    on<LoadHome>(_onLoadHome);
    on<LoadMatchesByDate>(_onLoadMatchesByDate);
    on<CheckBankruptcy>(_checkBankruptcy);
    add(LoadMatchesByDate(selectedDate));
  }

  Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());
    try {
      final pointResponse = await _stageRepository.getMyPoint(stageId);
      final point = SearchMyPointResponse(point: pointResponse.point);

      final rankingResponse =
          await _stageRepository.searchRanking(stageId, 0, 5);
      final ranking = rankingResponse.rank;

      final postsResponse =
          await _stageRepository.getCommunityPosts(stageId, 0, 5, null, null);
      final communityPosts = postsResponse.board;

      final activeGameResponse =
          await _miniGameRepository.getActiveGame(stageId);

      final gameResponse = await _stageRepository.getGame(stageId);
      bool isBankruptcy = false;

      if (0 == point.point) {
        String? storageResponse =
            await _storage.read(key: "stageBankruptcy$stageId");
        bool bankruptcyResponse =
            bool.tryParse(storageResponse ?? 'false') ?? false;
        if (!bankruptcyResponse) {
          isBankruptcy = true;
        }
      }

      emit(LoadedHomeState(
          isBankruptcy: isBankruptcy,
          communityPosts: communityPosts,
          ranking: ranking,
          points: point,
          activeGameResponse: activeGameResponse,
          gameResponse: gameResponse));
    } catch (e) {
      log(e.toString(), name: 'HomeBloc');
      emit(ErrorHomeState());
    }
  }

  Future<void> _onLoadMatchesByDate(
      LoadMatchesByDate event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingMatchHomeState());
      selectedDate = event.selectedDate;
      final matchesResponse = await _stageRepository.searchMatch(
          stageId, selectedDate.year, selectedDate.month, selectedDate.day);
      matches = matchesResponse.matches;
      add(LoadHome());
    } catch (e) {
      print(e);
      emit(ErrorHomeState());
    }
  }

  Future<void> _checkBankruptcy(
      CheckBankruptcy event, Emitter<HomeState> emit) async {
    try {
      if (event.isBankruptcy) {
        await _storage.write(key: "stageBankruptcy$stageId", value: "true");
      } else {
        await _storage.delete(key: "stageBankruptcy$stageId");
      }
    } catch (e) {
      log(e.toString(), name: 'HomeBloc');
    }
  }
}
