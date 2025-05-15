abstract class RankingEvent {}
class GetRanking extends RankingEvent {
  final int stageId;
  final bool isRefresh;

  GetRanking({required this.stageId, this.isRefresh = false});
}