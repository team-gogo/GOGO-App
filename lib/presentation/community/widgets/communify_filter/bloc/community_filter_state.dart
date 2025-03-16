import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';

abstract class CommunitySportFilterState {}

class DefaultCommunitySportFilterState extends CommunitySportFilterState {}

class SelectedCommunitySportFilterState extends CommunitySportFilterState {
  final GameType gameType;

  SelectedCommunitySportFilterState({required this.gameType});
}

abstract class CommunitySortFilterState {}

class DefaultCommunitySortFilterState extends CommunitySortFilterState {}

class SelectedCommunitySortFilterState extends CommunitySortFilterState {
  final SortType sortType;

  SelectedCommunitySortFilterState({required this.sortType});
}
