import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';

abstract class CommunitySportFilterEvent {}

class SelectCommunitySportFilterEvent extends CommunitySportFilterEvent {
  final GameType gameType;

  SelectCommunitySportFilterEvent({required this.gameType});
}

abstract class CommunitySortFilterEvent {}

class SelectCommunitySortFilterEvent extends CommunitySortFilterEvent {
  final SortType sortType;

  SelectCommunitySortFilterEvent({required this.sortType});
}
