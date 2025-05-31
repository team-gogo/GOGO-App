import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/mini_game/ticket_counts_response.dart';
import 'package:gogo_app/data/models/shop/request/buy_shop_item_request.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';
import 'package:gogo_app/data/repositories/shop/shop_repository.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_state.dart';

class MinigameDescriptionBloc
    extends Bloc<MinigameDescriptionEvent, MinigameDescriptionState> {
  MinigameDescriptionBloc() : super(MinigameDescriptionInitial()) {
    on<ChangeCategory>(_onUpdateGameCategory);
  }

  void _onUpdateGameCategory(
      ChangeCategory event, Emitter<MinigameDescriptionState> emit) {
    emit(MinigameDescriptionUpdated(minigameName: event.minigameName));
  }
}

class MinigameBloc extends Bloc<MinigameEvent, MinigameState> {

  final MiniGameRepository minigameRepository = GetIt.instance<MiniGameRepository>();
  final ShopRepository shopRepository = GetIt.instance<ShopRepository>();
  final StageRepository stageRepository = GetIt.instance<StageRepository>();

  MinigameBloc() : super(MinigameInitial()) {
    on<FetchMinigameInfo>(_onFetchMinigameInfo);
    on<PurchaseTicket>(_onPurchaseTicket);
  }

  void _onFetchMinigameInfo(
      FetchMinigameInfo event, Emitter<MinigameState> emit) async {
    emit(MinigameInfoLoading());
    try {
      final shopTicketStatusResponse = await shopRepository.shopTicketStatusResponse(event.stageId);
      final ticketCountsResponse = await minigameRepository.getTicketCount(event.stageId);
      final betLimitResponse = await minigameRepository.getBetLimit(event.stageId);
      final activeGameResponse = await minigameRepository.getActiveGame(event.stageId);
      final userPointResponse = await stageRepository.getMyPoint(event.stageId);

      emit(MinigameInfoLoaded(
        shopTicketStatusResponse: shopTicketStatusResponse, 
        ticketCountsResponse: ticketCountsResponse,
        betLimitResponse: betLimitResponse,
        activeGameResponse: activeGameResponse,
        userPointResponse: userPointResponse,
      ));
    } catch (e) {
      emit(MinigameInfoError(message: e.toString()));
    }
  }

  void _onPurchaseTicket(
      PurchaseTicket event, Emitter<MinigameState> emit) async {
    final currentState = state;
    if (currentState is! MinigameInfoLoaded) return;

    try {
      // 티켓 구매 요청
      final shopId = currentState.shopTicketStatusResponse.shopId;
      final buyRequest = BuyShopItemRequest(
        miniGameId: event.stageId, // 또는 다른 ID 사용
        ticketQuantity: event.quantity,
        ticketType: event.ticketType,
      );

      await shopRepository.buyShopItemRequest(shopId, buyRequest);

      // 구매 성공 상태 emit
      emit(TicketPurchaseSuccess());

      // 구매 후 정보 갱신
      add(FetchMinigameInfo(stageId: event.stageId));

    } catch (e) {
      emit(TicketPurchaseError(message: e.toString()));
    }
  }
}
