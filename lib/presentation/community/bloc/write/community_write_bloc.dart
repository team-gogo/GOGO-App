import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/stage/community/community_write_request.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'community_write_event.dart';
import 'community_write_state.dart';

class CommunityWriteBloc
    extends Bloc<CommunityWriteEvent, CommunityWriteState> {
  static const int maxLength = 30;

  final StageRepository repository = GetIt.instance<StageRepository>();
  GameType gameType;
  final int stageId;

  CommunityWriteBloc({required this.gameType, required this.stageId})
      : super(CommunityWriteState(title: '', content: '', isValid: false)) {
    on<TitleChanged>((event, emit) {
      final newTitle = event.title.length > maxLength
          ? event.title.substring(0, maxLength)
          : event.title;
      emit(state.copyWith(
        title: newTitle,
        isValid: newTitle.isNotEmpty && state.content.isNotEmpty,
      ));
    });
    on<ContentChanged>((event, emit) {
      final newContent = event.content.length > maxLength
          ? event.content.substring(0, maxLength)
          : event.content;
      emit(state.copyWith(
        content: newContent,
        isValid: state.title.isNotEmpty && newContent.isNotEmpty,
      ));
    });
    on<PostWrite> ((event,emit) async {
    try {
      await repository.createCommunityPost(
      stageId, 
      CommunityWriteRequest(
        title: event.title, 
        content: event.content, 
        gameCategory: gameType,
        ),
      );
      emit(CommunityWriteState(title: '', content: '', isValid: false));
    } catch(e) {
      emit(PostWriteErrorState(message: e.toString()));
    }
  });
}
}