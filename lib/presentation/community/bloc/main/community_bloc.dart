import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/stage_type.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'community_event.dart';
import 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {

  final StageRepository repository = GetIt.instance<StageRepository>();

  final int stageId;

  CommunityBloc({required this.stageId}) : super(CommunityLoadingState()) {
    on<FetchCommunityEvent>(_onFetchCommunity);
  }

  Future<void> _onFetchCommunity(
      FetchCommunityEvent event, Emitter<CommunityState> emit) async {
    emit(CommunityLoadingState());
    try {
      final response = await repository.getCommunityPosts(
        stageId, 
        event.queryString.page,
        event.queryString.size,
        event.queryString.type,
        event.queryString.sort,
        );
        emit(CommunityLoadedState(response: response));
    } catch (e) {
      emit(CommunityErrorState(message: e.toString()));
    }
  }
}

class CommunityFilterBloc extends Bloc<CommunityEvent,CommunityState>{
  CommunityFilterBloc(super.initialState);

  
}