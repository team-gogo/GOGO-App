import 'package:bloc/bloc.dart';
import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/stage_type.dart';
import 'community_event.dart';
import 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityLoadingState()) {
    on<FetchCommunityEvent>(_onFetchCommunity);
  }

  Future<void> _onFetchCommunity(
      FetchCommunityEvent event, Emitter<CommunityState> emit) async {
    emit(CommunityLoadingState());
    try {
      // final response = _generateMockData();
      emit(
        CommunityLoadedState(
          response: SearchBoardResponse(
            info: Info(totalPage: 20, totalElement: 200),
            board: [
              Board(
                boardId: 0,
                gameCategory: GameType.BADMINTON,
                title: 'asdf',
                likeCount: 1,
                createdAt: DateTime(1),
                commentCount: 1,
                stageType: StageType.FAST,
                author: Author(
                    studentId: 1,
                    name: 'qwer',
                    classNumber: 1234,
                    studentNumber: 1234),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      emit(CommunityErrorState(message: e.toString()));
    }
  }
}
