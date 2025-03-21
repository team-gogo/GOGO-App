import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gogo_app/data/repositories/search_school/search_school_repository.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/get_it_module/get_it_module.dart';
import '../../../../data/models/auth/additional_sign_up/additional_sign_up_response.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final TextEditingController _schoolController = TextEditingController();
  final SearchSchoolRepository _searchSchoolRepository =
      locator<SearchSchoolRepository>();
  List<School> searchSchoolResponse = [];
  School? searchSchoolResponseSelected;

  TextEditingController get schoolController => _schoolController;

  SchoolBloc() : super(InitSchoolState()) {
    on<EnterSchoolEvent>(
      _handlerEnterSchoolEvent,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .flatMap(mapper),
    );
    on<ChooseSchoolEvent>(_handlerChooseSchoolEvent);
    _schoolController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    add(EnterSchoolEvent(_schoolController.text));
  }

  void _handlerEnterSchoolEvent(
      EnterSchoolEvent event, Emitter<SchoolState> emit) async {
    var result = await _searchSchoolRepository.getSchoolInfo(
        event.search, dotenv.env['SCHOOL_API_KEY']!, 'json', 1, 100);
    print(result);
    searchSchoolResponse = result.row;
    searchSchoolResponse.isNotEmpty
        ? emit(EnableSchoolState())
        : emit(DisableSchoolState());
  }

  void _handlerChooseSchoolEvent(
      ChooseSchoolEvent event, Emitter<SchoolState> emit) {
    _schoolController.removeListener(_onTextChanged);
    _schoolController.text = event.searchSchoolResponse.name;
    searchSchoolResponseSelected = event.searchSchoolResponse;
    _schoolController.addListener(_onTextChanged);
    emit(ChooseSchoolState());
  }

  @override
  Future<void> close() {
    _schoolController.removeListener(_onTextChanged);
    return super.close();
  }
}
