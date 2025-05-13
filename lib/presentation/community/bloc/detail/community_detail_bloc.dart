import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/community/community_comment_request.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_event.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_state.dart';

class CommunityDetailBloc extends Bloc<CommunityDetailEvent, CommunityDetailState> {
  final StageRepository repository = GetIt.instance<StageRepository>();
  final int boardId;

  CommunityDetailBloc({required this.boardId}) : super(CommunityDetailLoadingState()) {
    on<FetchCommunityDetailEvent>(_onFetchCommunityDetail);
    on<CommunityCommentLiked>(_onLikedComment);
    on<CommunityWriteComment>(_onWriteComment);
  }

  Future<void> _onFetchCommunityDetail(
    FetchCommunityDetailEvent event,
    Emitter<CommunityDetailState> emit,
  ) async {
    emit(CommunityDetailLoadingState());
    try {
      final response = await repository.getCommunityPostDetail(boardId);
      emit(CommunityDetailLoadedState(response: response));
    } catch (e) {
      emit(CommunityDetailErrorState(message: e.toString()));
    }
  }

  Future<void> _onLikedComment(
    CommunityCommentLiked event,
    Emitter<CommunityDetailState> emit,
  ) async {
    if (state is! CommunityDetailLoadedState) return;

    final currentState = state as CommunityDetailLoadedState;
    final oldResponse = currentState.response;

    final updatedComments = oldResponse.comment.map((comment) {
      if (comment.commentId == event.commentId) {
        final isLiked = !(comment.isLiked ?? false);
        final likeCount = (comment.likeCount ?? 0) + (isLiked ? 1 : -1);
        return comment.copyWith(
          isLiked: isLiked,
          likeCount: likeCount,
        );
      }
      return comment;
    }).toList();

    final updatedResponse = oldResponse.copyWith(comment: updatedComments);
    emit(CommunityDetailLoadedState(response: updatedResponse));

    try {
      await repository.likeCommunityComment(event.commentId);
    } catch (e) {
      emit(CommunityDetailLoadedState(response: oldResponse));
      emit(CommunityDetailErrorState(message: '댓글 좋아요 처리 중 오류 발생'));
    }
  }

  Future<void> _onWriteComment(
    CommunityWriteComment event,
    Emitter<CommunityDetailState> emit
) async {
  try {
    await repository.createCommunityComment(
      boardId,
      CommunityCommentRequest(content: event.content),
    );
    final response = await repository.getCommunityPostDetail(boardId);
    emit(CommunityDetailLoadedState(response: response));
  } catch (e) {
    emit(CommunityDetailErrorState(message: e.toString()));
  }
}
}