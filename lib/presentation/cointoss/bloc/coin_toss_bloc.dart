import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/presentation/cointoss/bloc/coin_toss_event.dart';
import 'package:video_player/video_player.dart';
import '../../../data/models/mini_game/betting/coin_toss_request.dart';
import 'coin_toss_state.dart';

class CoinTossBloc extends Bloc<CoinTossEvent, CoinTossState> {
  CoinTossBloc() : super(CoinTossInitial()) {
    on<GetCoinToss>(_getCoinToss);
    on<BettingCoinToss>(_bettingCoinToss);
  }

  final MiniGameRepository _miniGameRepository =
      GetIt.instance<MiniGameRepository>();
  final StageRepository _stageRepository = GetIt.instance<StageRepository>();

  Future<void> _getCoinToss(
      GetCoinToss event, Emitter<CoinTossState> emit) async {
    try {
      final ticketResponse =
          await _miniGameRepository.getTicketCount(event.stageId);
      final betLimitResponse =
          await _miniGameRepository.getBetLimit(event.stageId);
      final pointResponse = await _stageRepository.getMyPoint(event.stageId);

      emit(CoinTossLoaded(
        ticketCountsResponse: ticketResponse,
        pointResponse: pointResponse,
        betLimitResponse: betLimitResponse,
      ));
    } catch (e) {
      emit(CoinTossFailure(error: e.toString()));
    }
  }

  Future<void> _bettingCoinToss(
      BettingCoinToss event, Emitter<CoinTossState> emit) async {
    try {
      if (state is CoinTossLoaded) {
        final result = await _miniGameRepository.getCoinTossBetting(
            event.stageId,
            CoinTossRequest(
              amount: event.amount,
              bet: event.bet,
            ));
        if (result.result) {
          emit(CoinTossBettingSuccess(bet: event.bet));
        } else {
          emit(CoinTossBettingFailure(bet: event.bet));
        }
      }
    } catch (e) {
      emit(CoinTossFailure(error: e.toString()));
    }
  }
}
