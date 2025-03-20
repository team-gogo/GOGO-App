import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';

class CommunityState {
  final String title;
  final String content;
  final bool isValid;

  CommunityState({
    required this.title,
    required this.content,
    required this.isValid,
  });

  CommunityState copyWith({
    String? title,
    String? content,
    bool? isValid,
  }) {
    return CommunityState(
      title: title ?? this.title,
      content: content ?? this.content,
      isValid: isValid ?? this.isValid,
    );
  }
}

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
