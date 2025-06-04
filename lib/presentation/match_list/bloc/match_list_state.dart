import '../../../data/models/common/match_dto.dart';

abstract class MatchListState {}

class InitMatchList extends MatchListState {}

class LoadingMatchList extends MatchListState {}

class LoadedMatchList extends MatchListState {
  final List<MatchDto> matchList;
  final bool hasReachedMax;

  LoadedMatchList({
    required this.matchList,
    required this.hasReachedMax,
  });
}

class BettingSuccess extends MatchListState {}

class BettingFailure extends MatchListState {
  final String message;
  BettingFailure(this.message);
}
