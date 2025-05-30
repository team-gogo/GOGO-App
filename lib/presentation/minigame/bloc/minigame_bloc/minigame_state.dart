import 'package:gogo_app/data/models/mini_game/ticket_counts_response.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';

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

  MinigameInfoLoaded({required this.shopTicketStatusResponse, required this.ticketCountsResponse});
}

class MinigameInfoError extends MinigameState {
  final String message;

  MinigameInfoError({required this.message});
}