// search_match_event.dart
abstract class SearchMatchEvent {}

class SearchMatchRequested extends SearchMatchEvent {
  final int matchId;

  SearchMatchRequested({required this.matchId});
}
