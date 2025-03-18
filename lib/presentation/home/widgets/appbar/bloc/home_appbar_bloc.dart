import 'package:bloc/bloc.dart';
import 'package:gogo_app/presentation/home/widgets/appbar/bloc/home_appbar_event.dart';
import 'package:gogo_app/presentation/home/widgets/appbar/bloc/home_appbar_state.dart';

class HomeAppbarBloc extends Bloc<HomeAppbarEvent, HomeAppbarState> {
  HomeAppbarBloc() : super(InitHomeAppbarState()) {
    on<SelectHomeAppbarEvent>(_handleSelectHomeAppbarEvent);
  }

  void _handleSelectHomeAppbarEvent(
      SelectHomeAppbarEvent event, Emitter<HomeAppbarState> emit) {
    emit(SelectHomeAppbarState(index: event.index));
  }
}
