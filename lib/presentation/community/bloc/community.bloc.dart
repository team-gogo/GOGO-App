import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/community/bloc/community_event.dart';
import 'package:gogo_app/presentation/community/bloc/community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  static const int maxLength = 30;

  CommunityBloc()
      : super(CommunityState(title: '', content: '', isValid: false)) {
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
  }
}
