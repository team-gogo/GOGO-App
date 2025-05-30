import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/mini_game/ticket_counts_response.dart';
import 'package:gogo_app/data/models/shop/response/shop_ticket_status_response.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';
import 'package:gogo_app/data/repositories/shop/shop_repository.dart';
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

  MinigameBloc() : super(MinigameInitial()) {
    on<FetchMinigameInfo>(_onFetchMinigameInfo);
  }

  void _onFetchMinigameInfo(
      FetchMinigameInfo event, Emitter<MinigameState> emit) async {
    emit(MinigameInfoLoading());
    try {
      final shopTicketStatusResponse = await shopRepository.shopTicketStatusResponse(event.stageId);

      final ticketCountsResponse = await minigameRepository.getTicketCount(event.stageId);
      
      emit(MinigameInfoLoaded(shopTicketStatusResponse: shopTicketStatusResponse, ticketCountsResponse: ticketCountsResponse));
    } catch (e) {
      emit(MinigameInfoError(message: e.toString()));
    }
  }
}
