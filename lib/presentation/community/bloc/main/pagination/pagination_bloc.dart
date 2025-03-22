import 'package:bloc/bloc.dart';
import 'package:gogo_app/presentation/community/bloc/main/pagination/pagination_event.dart';
import 'package:gogo_app/presentation/community/bloc/main/pagination/pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc() : super(PaginationInitial()) {
    on<ChangePageEvent>((event, emit) {
      emit(PaginationChanged(page: event.page));
    });
  }
}
