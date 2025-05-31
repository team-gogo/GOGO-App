import 'package:gogo_app/data/models/shop/enum_type/ticket_type.dart';

abstract class MinigameDescriptionEvent {}

class ChangeCategory extends MinigameDescriptionEvent {
  final String minigameName;

  ChangeCategory({required this.minigameName});
}

abstract class MinigameEvent {}

class FetchMinigameInfo extends MinigameEvent {
  final int stageId;

  FetchMinigameInfo({required this.stageId});
}

class PurchaseTicket extends MinigameEvent {
  final int stageId;
  final TicketType ticketType;
  final int quantity;

  PurchaseTicket({
    required this.stageId,
    required this.ticketType,
    required this.quantity,
  });
}
