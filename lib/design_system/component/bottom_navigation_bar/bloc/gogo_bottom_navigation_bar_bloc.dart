import 'package:bloc/bloc.dart';
import 'package:gogo_app/design_system/component/bottom_navigation_bar/bloc/gogo_bottom_navigation_bar_event.dart';

class GogoBottomNavigationBarBloc extends Bloc<GogoBottomNavigationBarEvent, int> {
  GogoBottomNavigationBarBloc() : super(0) {
    on<GogoBottomNavigationBarEvent>((event, emit) {
      emit(event.index);
    });
  }
}