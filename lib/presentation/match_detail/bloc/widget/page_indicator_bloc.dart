import 'package:flutter_bloc/flutter_bloc.dart';
import 'page_indicator_event.dart';
import 'page_indicator_state.dart';

class PageIndicatorBloc extends Bloc<PageIndicatorEvent, PageIndicatorState> {
  PageIndicatorBloc() : super(PageIndicatorState(0)) {
    on<PageChangedEvent>((event, emit) {
      emit(PageIndicatorState(event.index));
    });
  }
}
