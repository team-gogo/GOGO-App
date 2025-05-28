import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';

abstract class MatchListEvent {}

class LoadItems extends MatchListEvent {
  final GameType? gameType;
  final SortOrder? sortOrder;

  LoadItems({this.gameType, this.sortOrder});
}

enum SortOrder { ascending, descending }
