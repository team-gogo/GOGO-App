import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/models/mini_game/betting/yavarwee_request.dart';
import 'package:gogo_app/data/repositories/mini_game/mini_game_repository.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_state.dart';

class ShellGameBloc extends Bloc<ShellgameEvent, ShellgameState> {
  final MiniGameRepository _miniGameRepository = GetIt.instance<MiniGameRepository>();
  int? _initialBetAmount; // 베팅 금액 저장용
  int? _currentStageId; // 현재 스테이지 ID 저장용

  ShellGameBloc() : super(ShellgameInitial()) {
    on<PlaceBet>(_onPlaceBet);
    on<BetPlaced>(_onBetPlaced);
    on<StartShuffle>(_onStartShuffle);
    on<UpdateCupOrder>(_onUpdateCupOrder);
    on<EndShuffle>(_onEndShuffle);
    on<NextRound>(_onNextRound);
    on<ResetGame>(_onResetGame);
    on<ClearResult>(_onClearResult);
    on<StartTimer>(_onStartTimer);
    on<UpdateTimer>(_onUpdateTimer);
    on<TimeOut>(_onTimeOut);
    on<PlaySelect>(_onPlaySelect);
    on<ShowSuccessModal>(_onShowSuccessModal);
    on<ContinueToNextRound>(_onContinueToNextRound);
    on<QuitGame>(_onQuitGame);
    on<SubmitGameResult>(_onSubmitGameResult);
    on<GameResultSubmitted>(_onGameResultSubmitted);
  }

  void _onPlaceBet(PlaceBet event, Emitter<ShellgameState> emit) async {
    emit(ShellgameGameState(
      round: state.round,
      isBetting: true,
    ));
    
    try {
      _initialBetAmount = event.amount; // 베팅 금액 저장
      _currentStageId = event.stageId; // 스테이지 ID 저장
      final body = {"amount": event.amount};
      final response = await _miniGameRepository.placeYavarweeBet(event.stageId, body);
      
      add(BetPlaced(uuid: response.uuid));
    } catch (e) {
      // 베팅 실패 시 초기 상태로 돌아가기
      emit(ShellgameGameState(round: state.round));
      print('베팅 실패: $e');
    }
  }

  void _onBetPlaced(BetPlaced event, Emitter<ShellgameState> emit) {
    emit(ShellgameGameState(
      round: state.round,
      betUuid: event.uuid,
      isGameStarted: true,
    ));
    
    // 베팅 성공 후 자동으로 셔플 시작
    add(StartShuffle());
  }

  void _onStartShuffle(StartShuffle event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(isShuffling: true));
    }
  }

  void _onUpdateCupOrder(UpdateCupOrder event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(cupOrder: List<int>.from(event.cupOrder)));
    }
  }

  void _onEndShuffle(EndShuffle event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(
        isShuffling: false,
        ballPosition: event.ballPosition,
      ));
    }
  }

  void _onNextRound(NextRound event, Emitter<ShellgameState> emit) {
    final currentRound = state.round;

    if (currentRound >= 5) {
      if (event.isWin) {
        final message = "야바위에 성공했습니다.";
        emit(ShellgameGameState(
          round: 1,
          playSelect: -1,
          resultMessage: message,
          earnedPoints: event.earnedScore,
          isWin: true,
          cupOrder: [0, 1, 2],
          betUuid: state.betUuid,
          isGameOver: true,
        ));
        // 5라운드 성공 시 서버에 결과 전송
        if (state.betUuid != null) {
          add(SubmitGameResult(
            stageId: _currentStageId ?? 1,
            proof: "success",
            isWin: true,
            finalRound: currentRound,
          ));
        }
      } else {
        final message = "야바위에 실패했습니다.";
        emit(ShellgameGameState(
          round: currentRound,
          resultMessage: message,
          earnedPoints: -event.earnedScore,
          isWin: false,
          betUuid: state.betUuid,
          isGameOver: true,
        ));
        // 게임 실패 시 서버에 결과 전송
        if (state.betUuid != null) {
          add(SubmitGameResult(
            stageId: _currentStageId ?? 1,
            proof: "failure",
            isWin: false,
            finalRound: currentRound,
          ));
        }
      }
    } else {
      if (event.isWin) {
        final message = "야바위에 성공했습니다.";
        emit(ShellgameGameState(
          round: currentRound + 1, 
          playSelect: -1,
          resultMessage: message,
          earnedPoints: event.earnedScore,
          isWin: true,
          cupOrder: [0, 1, 2],
          betUuid: state.betUuid,
        ));
      } else {
        final message = "야바위에 실패했습니다.";
        emit(ShellgameGameState(
          round: 1,
          playSelect: -1,
          resultMessage: message,
          earnedPoints: -event.earnedScore,
          isWin: false,
          cupOrder: [0, 1, 2],
          betUuid: state.betUuid,
          isGameOver: true,
        ));
        // 라운드 실패 시 서버에 결과 전송
        if (state.betUuid != null) {
          add(SubmitGameResult(
            stageId: _currentStageId ?? 1,
            proof: "failure",
            isWin: false,
            finalRound: currentRound,
          ));
        }
      }
    }
  }

  void _onResetGame(ResetGame event, Emitter<ShellgameState> emit) {
    emit(ShellgameInitial());
  }
  
  void _onClearResult(ClearResult event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(
        resultMessage: null,
        earnedPoints: null,
        isWin: null,
      ));
    }
  }

  void _onPlaySelect(PlaySelect event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(playSelect: event.select));
    }
  }

  void _onStartTimer(StartTimer event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(
        isTimerRunning: true,
        timerSeconds: event.seconds,
      ));
    }
  }
  
  void _onUpdateTimer(UpdateTimer event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(timerSeconds: event.seconds));
    }
  }
  
  void _onTimeOut(TimeOut event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(isTimerRunning: false));
    }
  }

  void _onShowSuccessModal(ShowSuccessModal event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(
        showSuccessModal: true,
        earnedPoints: event.earnedPoints,
      ));
    }
  }

  void _onContinueToNextRound(ContinueToNextRound event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      final currentRound = currentState.round;
      
      if (currentRound >= 5) {
        // 5라운드 완료 시 게임 종료
        emit(currentState.copyWith(
          isGameOver: true,
          resultMessage: "모든 라운드를 완주했습니다!",
          showSuccessModal: false,
        ));
      } else {
        // 다음 라운드로 진행
        emit(ShellgameGameState(
          round: currentRound + 1,
          playSelect: -1,
          cupOrder: [0, 1, 2], // 기본 순서로 리셋
          betUuid: currentState.betUuid,
        ));
      }
    }
  }

  void _onQuitGame(QuitGame event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(
        isGameOver: true,
        resultMessage: "게임을 종료했습니다.",
        showSuccessModal: false,
      ));
      // 중간에 그만두기 시 서버에 결과 전송
      if (currentState.betUuid != null) {
        add(SubmitGameResult(
          stageId: _currentStageId ?? 1,
          proof: "quit",
          isWin: true,
          finalRound: currentState.round,
        ));
      }
    }
  }

  void _onSubmitGameResult(SubmitGameResult event, Emitter<ShellgameState> emit) async {
    try {
      final betAmount = _initialBetAmount ?? 0;
      final request = YavarweeRequest(
        proof: event.proof,
        uuid: state.betUuid ?? '',
        amount: betAmount,
        round: event.finalRound,
      );
      
      final result = await _miniGameRepository.getYavarweeBetting(event.stageId, request);
      
      // 서버 응답 처리 (result는 int 타입)
      print('게임 결과 전송 완료. 서버 응답: $result');
      add(GameResultSubmitted(serverResult: result));
      
    } catch (e) {
      print('게임 결과 전송 실패: $e');
      add(GameResultSubmitted(serverResult: -1)); // 실패 시 -1
    }
  }
  
  void _onGameResultSubmitted(GameResultSubmitted event, Emitter<ShellgameState> emit) {
    if (state is ShellgameGameState) {
      final currentState = state as ShellgameGameState;
      emit(currentState.copyWith(
        isSubmittingResult: false,
        serverResult: event.serverResult,
      ));
    }
  }
}

