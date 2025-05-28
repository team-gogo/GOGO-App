import '../../../data/models/mini_game/betting/coin_toss_request.dart';

abstract class CoinTossEvent {}

class GetCoinToss extends CoinTossEvent {
  final int stageId;

  GetCoinToss({required this.stageId});
}

class BettingCoinToss extends CoinTossEvent {
  final int stageId;
  final int amount;
  final CoinTossStatus bet;

  BettingCoinToss(
      {required this.stageId, required this.amount, required this.bet});
}
