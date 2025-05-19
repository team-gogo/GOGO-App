abstract class MatchListEvent {}

class GetMatchList extends MatchListEvent {
  final int page;
  final int pageSize;

  GetMatchList({
    required this.page,
    required this.pageSize,
  });
}