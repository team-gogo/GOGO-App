// search_match_state.dart
import 'package:gogo_app/data/models/stage/search_stage/search_match_info_response.dart';

abstract class SearchMatchState {}

class SearchMatchInitial extends SearchMatchState {}

class SearchMatchLoading extends SearchMatchState {}

class SearchMatchSuccess extends SearchMatchState {
  final SearchMatchInfoResponse matchInfo;

  SearchMatchSuccess({required this.matchInfo});
}

class SearchMatchFailure extends SearchMatchState {
  final String message;

  SearchMatchFailure({required this.message});
}
