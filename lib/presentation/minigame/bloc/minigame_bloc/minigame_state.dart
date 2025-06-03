import 'package:gogo_app/data/models/mini_game/active_game_response.dart';
import 'package:gogo_app/data/models/mini_game/ticket_counts_response.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_my_point_response.dart';

import '../../../../data/models/mini_game/bet_limit_response.dart';

abstract class MinigameDescriptionState {}

class MinigameDescriptionInitial extends MinigameDescriptionState {}

class MinigameDescriptionUpdated extends MinigameDescriptionState {
  final String minigameName;

  MinigameDescriptionUpdated({required this.minigameName});
}

abstract class MinigameState {}

class MinigameInitial extends MinigameState {}

class MinigameInfoLoading extends MinigameState {}

class MinigameInfoLoaded extends MinigameState {
  final ShopTicketStatusResponse shopTicketStatusResponse;
  final TicketCountsResponse ticketCountsResponse;
  final ActiveGameResponse activeGameResponse;
  final SearchMyPointResponse userPointResponse;

  MinigameInfoLoaded({
    required this.shopTicketStatusResponse,
    required this.ticketCountsResponse,
    required this.activeGameResponse,
    required this.userPointResponse,
  });
}

class MinigameInfoError extends MinigameState {
  final String message;

  MinigameInfoError({required this.message});
}

class TicketPurchaseSuccess extends MinigameState {}

class TicketPurchaseError extends MinigameState {
  final String message;

  TicketPurchaseError({required this.message});
}