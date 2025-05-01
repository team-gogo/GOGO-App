import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_event.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_state.dart';
import 'package:gogo_app/presentation/community/bloc/main/community_state.dart';

class CommunityDetailBloc extends Bloc<CommunityDetailEvent,CommunityDetailState>{

  final StageRepository repository = GetIt.instance<StageRepository>();

  final int boardId;

  CommunityDetailBloc({required this.boardId}) : super(CommunityDetailLoadingState()) {
    on<FetchCommunityDetailEvent>(_onFetchCommunityDetail);
    on<CommunityCommentLiked>(_onLikedComment);
  }

  Future<void> _onFetchCommunityDetail(
    FetchCommunityDetailEvent event, Emitter<CommunityDetailState> emit) async {
    emit(CommunityDetailLoadingState());
    try {
      final response = await repository.getCommunityPostDetail(
        boardId,
        );
        emit(CommunityDetailLoadedState(response: response));
    } catch (e) {
      emit(CommunityDetailErrorState(message: e.toString()));
    }
  }

  Future<void> _onLikedComment(CommunityCommentLiked event, Emitter<CommunityDetailState> emit) async {
    emit(CommunityDetailLoadingState());
    try {
      final response = await repository.likeCommunityComment(
        event.commentId,
      );
      emit(CommunityDetailPostLoadedState(response: response));
    } catch(e) {
      emit(CommunityDetailErrorState(message: e.toString()));
    }
  }
  
} 