import 'package:gogo_app/data/models/mini_game/bet_limit_response.dart';
import 'package:gogo_app/data/models/mini_game/betting/coin_toss_response.dart';
import 'package:gogo_app/data/models/mini_game/ticket_counts_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_point_response.dart';

abstract class CoinTossState {}

class CoinTossInitial extends CoinTossState {}

class CoinTossLoading extends CoinTossState {}

class CoinTossLoaded extends CoinTossState {
  final TicketCountsResponse ticketCountsResponse;
  final SearchMyPointResponse pointResponse;
  final BetLimitResponse betLimitResponse;

  CoinTossLoaded(
      {required this.pointResponse,
      required this.betLimitResponse,
      required this.ticketCountsResponse});
}

class CoinTossFailure extends CoinTossState {
  final String error;

  CoinTossFailure({required this.error});
}

class CoinTossBetting extends CoinTossState {
  final CoinTossResponse response;

  CoinTossBetting({required this.response});
}
