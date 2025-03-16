import 'package:bloc/bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/sex/sex_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/sex/sex_state.dart';

class SexBloc extends Bloc<SexEvent, SexState> {
  Sex? _sexController;

  Sex? get sexController => _sexController;

  set sexController(Sex? sex) {
    _sexController = sex;
    add(EnterSexEvent());
  }

  SexBloc(this._sexController) : super(DisableSexState()) {
    on<EnterSexEvent>(_handlerEnterSexEvent);
  }

  void _handlerEnterSexEvent(SexEvent event, Emitter<SexState> emit) {
    if (_sexController == null) {
      emit(DisableSexState());
    }
    if (_sexController == Sex.male) {
      emit(EnableMaleSexState());
    }
    if (_sexController == Sex.female) {
      emit(EnableFemaleSexState());
    }
  }
}
