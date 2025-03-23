import 'package:bloc/bloc.dart';
import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:gogo_app/data/models/stage/stage_type.dart';
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
      final response = _generateMockData();
      emit(CommunityLoadedState(response: response));
    } catch (e) {
      emit(CommunityErrorState(message: e.toString()));
    }
  }
}

SearchBoardResponse _generateMockData() {
  return SearchBoardResponse(
    info: Info(
      totalPage: 5,
      totalElement: 20,
    ),
    board: [
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
        boardId: 2,
        gameType: GameType.BADMINTON,
        title: 'Challenging Puzzle Game',
        likeCount: 80,
        createdAt: DateTime.parse('2025-03-19T10:15:00'),
        stageType: StageType.FAST,
        author: Author(
          studentId: 67890,
          name: 'Jane Smith',
          classNumber: 2,
          studentNumber: 3,
        ),
        isFiltered: false,
      ),
      Board(
        boardId: 2,
        gameType: GameType.BADMINTON,
        title: 'Challenging Puzzle Game',
        likeCount: 80,
        createdAt: DateTime.parse('2025-03-19T10:15:00'),
        stageType: StageType.FAST,
        author: Author(
          studentId: 67890,
          name: 'Jane Smith',
          classNumber: 2,
          studentNumber: 3,
        ),
        isFiltered: false,
      ),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      Board(
          boardId: 1,
          gameType: GameType.LOL,
          title: 'Exciting Action Game',
          likeCount: 120,
          createdAt: DateTime.parse('2025-03-20T14:30:00'),
          stageType: StageType.OFFICIAL,
          author: Author(
            studentId: 12345,
            name: 'John Doe',
            classNumber: 1,
            studentNumber: 1,
          ),
          isFiltered: false),
      // 추가 데이터...
    ],
  );
}
