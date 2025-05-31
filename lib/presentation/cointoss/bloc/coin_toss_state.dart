import 'package:gogo_app/data/models/mini_game/bet_limit_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/coin_toss_response.dart';
import 'package:gogo_app/data/models/mini_game/ticket_counts_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_point_response.dart';

import '../../../data/models/mini_game/betting/coin_toss_request.dart';

abstract class CoinTossState {}

class CoinTossInitial extends CoinTossState {}


class CoinTossLoaded extends CoinTossState {
  final TicketCountsResponse ticketCountsResponse;
  final SearchMyPointResponse pointResponse;
  final BetLimitResponse betLimitResponse;

  CoinTossLoaded(
      {required this.pointResponse,
      required this.betLimitResponse,
      required this.ticketCountsResponse});
}

class CoinTossBettingSuccess extends CoinTossState {
  final CoinTossStatus bet;

  CoinTossBettingSuccess({required this.bet});
}

class CoinTossBettingFailure extends CoinTossState {
  final CoinTossStatus bet;

  CoinTossBettingFailure({required this.bet});
}

class CoinTossFailure extends CoinTossState {
  final String error;

  CoinTossFailure({required this.error});
}
