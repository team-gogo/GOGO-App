abstract class RankingEvent {}

class GetRanking extends RankingEvent {
  final int stageId;

  GetRanking({required this.stageId});
}
