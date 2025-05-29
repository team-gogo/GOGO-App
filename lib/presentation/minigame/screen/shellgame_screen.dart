import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellGame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_state.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';
import 'dart:math' as math;
import 'dart:async';

// 게임 관련 상수들
class _GameConstants {
  static const int maxRounds = 5;
  static const int shuffleMoves = 15;
  static const int timerDuration = 10;
  static const int resultDisplayDuration = 3;
  
  // 컵 관련 상수
  static const int cupCount = 3;
  static const double cupWidth = 70.0;
  static const double cupSpacing = 95.0;
  static const double cupStartPosition = 10.0;
  
  // 애니메이션 상수
  static const int shuffleAnimationDuration = 250;
  static const int normalAnimationDuration = 400;
}

// 라운드별 설정
class _RoundConfig {
  static const Map<int, int> shuffleSpeeds = {
    1: 500,
    2: 400,
    3: 350,
    4: 300,
    5: 200,
  };
  
  static const Map<int, double> multipliers = {
    1: 1.1,
    2: 1.2,
    3: 1.5,
    4: 2.5,
    5: 5.0,
  };
  
  static int getShuffleSpeed(int round) => shuffleSpeeds[round] ?? 500;
  static double getMultiplier(int round) => multipliers[round] ?? 1.1;
}

// 게임 로직 관리 클래스
class _GameLogic {
  static bool canStartGame(ShellgameState state, String betText, int userPoint, int ticketsCount) {
    if (state.isShuffling || ticketsCount <= 0) return false;
    if (state is ShellgameRound) return true;
    
    final betAmount = int.tryParse(betText);
    return betAmount != null && betAmount > 0 && betAmount <= userPoint;
  }
  
  static String? getValidationError(ShellgameState state, String betText, int userPoint, int ticketsCount) {
    if (state.isShuffling) return '섞는 중입니다';
    if (ticketsCount <= 0) return '티켓이 부족합니다';
    if (betText.isEmpty) return '베팅 금액을 입력하세요';
    
    final betAmount = int.tryParse(betText);
    if (betAmount == null) return '올바른 숫자를 입력하세요';
    if (betAmount <= 0) return '0보다 큰 금액을 입력하세요';
    if (betAmount > userPoint) return '보유 포인트를 초과했습니다';
    
    return null;
  }
  
  static int calculateEarnedPoints(int betAmount, int round) {
    final multiplier = _RoundConfig.getMultiplier(round);
    return (betAmount * multiplier).round();
  }
  
  static bool shouldResetBetAmount(int round) {
    return round >= _GameConstants.maxRounds;
  }
}

class ShellgameScreen extends StatelessWidget {
  final int point;
  final int ticketsCount;

  const ShellgameScreen({super.key, required this.point, required this.ticketsCount});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShellGameBloc(),
      child: _ShellgameView(point: point, ticketsCount: ticketsCount),
    );
  }
}

class _ShellgameView extends StatefulWidget {
  final int point;
  final int ticketsCount;

  const _ShellgameView({required this.point, required this.ticketsCount});

  @override
  State<_ShellgameView> createState() => _ShellgameViewState();
}

class _ShellgameViewState extends State<_ShellgameView> with SingleTickerProviderStateMixin {
  late final TextEditingController _betController;
  int? _initialBetAmount; // 초기 베팅 금액 저장
  
  @override
  void initState() {
    super.initState();
    _betController = TextEditingController();
    // 텍스트 변경 시 UI 업데이트
    _betController.addListener(() {
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _betController.dispose();
    super.dispose();
  }
  
  bool _canStartGame(ShellgameState state) {
    return _GameLogic.canStartGame(state, _betController.text, widget.point, widget.ticketsCount);
  }
  
  int? _getBetAmount(ShellgameState state) {
    if (state is ShellgameRound && _initialBetAmount != null) {
      return _initialBetAmount!;
    }
    
    final betAmount = int.tryParse(_betController.text) ?? 0;
    if (betAmount <= 0 || betAmount > widget.point) return null;
    
    _initialBetAmount = betAmount;
    return betAmount;
  }
  
  void _startShuffling(BuildContext context) {
    final bloc = context.read<ShellGameBloc>();
    final currentState = bloc.state;
    
    final betAmount = _getBetAmount(currentState);
    if (betAmount == null) return;
    
    _performShuffleAnimation(bloc, currentState);
  }
  
  void _performShuffleAnimation(ShellGameBloc bloc, ShellgameState currentState) {
    List<int> currentOrder = [0, 1, 2];
    int ballPosition = 0;
    int actualMoves = 0;
    
    final speed = _RoundConfig.getShuffleSpeed(currentState.round);
    bloc.add(StartShuffle());
    
    Timer.periodic(Duration(milliseconds: speed), (timer) {
      // 컵 교환
      int index1 = math.Random().nextInt(_GameConstants.cupCount);
      int index2;
      
      do {
        index2 = math.Random().nextInt(_GameConstants.cupCount);
      } while (index1 == index2);
      
      // 위치 교환
      int temp = currentOrder[index1];
      currentOrder[index1] = currentOrder[index2];
      currentOrder[index2] = temp;
      
      // 공 위치 추적
      if (currentOrder[index1] == ballPosition) {
        ballPosition = index1;
      } else if (currentOrder[index2] == ballPosition) {
        ballPosition = index2;
      }
      
      bloc.add(UpdateCupOrder(cupOrder: List<int>.from(currentOrder)));
      actualMoves++;
      
      if (actualMoves >= _GameConstants.shuffleMoves) {
        timer.cancel();
        _finishShuffle(bloc, currentOrder, context);
      }
    });
  }
  
  void _finishShuffle(ShellGameBloc bloc, List<int> currentOrder, BuildContext context) {
    final finalBallPosition = currentOrder.indexOf(0);
    bloc.add(EndShuffle(ballPosition: finalBallPosition));
    bloc.add(StartTimer());
    _startCountdown(context);
  }
  
  void _checkResult(BuildContext context, ShellgameState state) {
    if (!_canSelectCup(state) || state.playSelect == -1) return;
    
    final betAmount = _initialBetAmount ?? 0;
    if (betAmount <= 0) return;
    
    final isWin = state.ballPosition == state.playSelect;
    final currentRound = state.round;
    
    if (isWin) {
      _handleWin(context, betAmount, currentRound);
    } else {
      _handleLoss(context, betAmount);
    }
  }
  
  bool _canSelectCup(ShellgameState state) {
    return state is ShellgameReady || state is ShellgameWaiting;
  }
  
  void _handleWin(BuildContext context, int betAmount, int round) {
    final earnedPoints = _GameLogic.calculateEarnedPoints(betAmount, round);
    
    context.read<ShellGameBloc>().add(ShowSuccessModal(
      earnedPoints: earnedPoints,
    ));
    
    if (_GameLogic.shouldResetBetAmount(round)) {
      _initialBetAmount = null;
    }
  }
  
  void _handleLoss(BuildContext context, int betAmount) {
    context.read<ShellGameBloc>().add(NextRound(
      isWin: false,
      earnedScore: betAmount,
    ));
    
    _initialBetAmount = null;
    _scheduleResultClear(context);
  }
  
  void _scheduleResultClear(BuildContext context) {
    Future.delayed(Duration(seconds: _GameConstants.resultDisplayDuration), () {
      if (context.mounted) {
        context.read<ShellGameBloc>().add(ClearResult());
      }
    });
  }
  
  void _startCountdown(BuildContext context) async {
    for (int i = _GameConstants.timerDuration - 1; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) break;
      
      final currentState = context.read<ShellGameBloc>().state;
      if (currentState is ShellgameWaiting) {
        context.read<ShellGameBloc>().add(UpdateTimer(seconds: i));
      } else {
        break;
      }
    }
    
    if (context.mounted) {
      final currentState = context.read<ShellGameBloc>().state;
      if (currentState is ShellgameWaiting) {
        context.read<ShellGameBloc>().add(TimeOut());
      }
    }
  }

  void _onCupSelected(BuildContext context, int index) {
    context.read<ShellGameBloc>().add(PlaySelect(select: index));
    
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkResult(context, context.read<ShellGameBloc>().state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GogoColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(
            child: BlocBuilder<ShellGameBloc, ShellgameState>(
              buildWhen: (previous, current) {
                // 필요한 상태 변경에서만 리빌드
                return previous.runtimeType != current.runtimeType ||
                       previous.round != current.round ||
                       previous.isShuffling != current.isShuffling ||
                       previous.playSelect != current.playSelect ||
                       previous.ballPosition != current.ballPosition ||
                       previous.resultMessage != current.resultMessage ||
                       previous.isTimerRunning != current.isTimerRunning ||
                       previous.timerSeconds != current.timerSeconds ||
                       previous.earnedPoints != current.earnedPoints;
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Column(
                      spacing: 24,
                      children: [
                        GogoTopBar(
                          title: '야바위',
                          onBackTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 42,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => 
                                  roundItem(index + 1, index + 1 == state.round),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: GogoColors.gray700,
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 280,
                              height: 284,
                              child: Stack(
                                children: List.generate(3, (index) => _CupWidget(cupIndex: index)),
                              ),
                            ),
                          ),
                        ),
                        // 번호 선택 버튼들
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                3,
                                (index) => GestureDetector(
                                  onTap: (state is ShellgameReady || state is ShellgameWaiting)
                                      ? () {
                                          _onCupSelected(context, index);
                                        }
                                      : null,
                                  child: selectNumberItem(index, index == state.playSelect, state),
                                ),
                              ),
                            ),
                          ),
                        ),
                        MinigameComponent(
                          point: widget.point,
                          ticketsCount: widget.ticketsCount,
                          action: state.isShuffling ? '섞는 중...' : '섞기',
                          controller: _betController,
                          verify: _canStartGame(state),
                          enabled: !(state is ShellgameRound),
                          onActionTap: _canStartGame(state) ? () {
                            _startShuffling(context);
                          } : null,
                        ),
                        // 타이머 바를 여기로 이동
                        _buildTimerBar(context, state),
                      ],
                    ),
                    // 상단 알림 오버레이
                    if (state.resultMessage != null && state.earnedPoints != null && state is! ShellgameSuccess)
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: _buildSuccessNotification(state),
                      ),
                    // 성공 모달
                    if (state is ShellgameSuccess)
                      Positioned.fill(
                        child: _NextRoundModal(
                          currentRound: state.round,
                          earnedPoints: state.earnedPoints,
                          onYes: () {
                            context.read<ShellGameBloc>().add(ContinueToNextRound());
                          },
                          onNo: () {
                            context.read<ShellGameBloc>().add(QuitGame());
                            context.read<ShellGameBloc>().add(ClearResult());  
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CupWidget extends StatelessWidget {
  final int cupIndex;
  
  const _CupWidget({
    required this.cupIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellGameBloc, ShellgameState>(
      buildWhen: (previous, current) {
        // 효율적인 리빌드 조건: cupOrder 변경 또는 상태 타입 변경시만
        if (previous.runtimeType != current.runtimeType) return true;
        
        // cupOrder에서 이 컵의 위치가 변경되었는지 확인
        final previousPosition = previous.cupOrder.indexOf(cupIndex);
        final currentPosition = current.cupOrder.indexOf(cupIndex);
        
        return previousPosition != currentPosition ||
               previous.playSelect != current.playSelect ||
               previous.ballPosition != current.ballPosition;
      },
      builder: (context, state) {
        // 현재 이 컵이 어느 위치에 있는지 찾기
        int positionIndex = state.cupOrder.indexOf(cupIndex);
        double leftPosition = _GameConstants.cupStartPosition + positionIndex * _GameConstants.cupSpacing;
        
        // 컵 상태 결정
        bool shouldShowOpen = false;
        bool showBall = false;
        bool isSelected = positionIndex == state.playSelect;
        
        if (state is ShellgameReady) {
          if (state.playSelect == -1) {
            // 섞기 전 공 보여주기
            shouldShowOpen = state.ballPosition == cupIndex;
            showBall = shouldShowOpen;
          } else {
            // 선택 후 결과 보여주기 - 모든 컵 열기
            shouldShowOpen = true;
            showBall = state.ballPosition == cupIndex;
          }
        }
        
        // 컵 선택 가능한지 확인
        bool canSelectCup = state is ShellgameReady || state is ShellgameWaiting;
        
        return AnimatedPositioned(
          duration: Duration(milliseconds: state.isShuffling 
            ? _GameConstants.shuffleAnimationDuration 
            : _GameConstants.normalAnimationDuration),
          curve: state.isShuffling ? Curves.easeOut : Curves.easeInOut,
          left: leftPosition,
          top: (284 - 80) / 2, // Stack 높이에서 컵 높이를 빼고 2로 나누어 가운데 정렬
          child: Container(
            width: _GameConstants.cupWidth,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 공이 있을 때 (컵 뒤에 배치)
                if (showBall && shouldShowOpen)
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // 컵 아이콘 (Container로 구현)
                Center(
                  child: _buildCupContainer(shouldShowOpen),
                ),
                
                // 선택 효과
                if (isSelected)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.yellow,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCupContainer(bool shouldShowOpen) {
    return Container(
      width: 70,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 컵 몸체 (사다리꼴)
          Container(
            width: shouldShowOpen ? 65 : 60,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFF4A90E2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(shouldShowOpen ? 8 : 5),
                topRight: Radius.circular(shouldShowOpen ? 8 : 5),
              ),
              border: Border.all(
                color: Color(0xFF2E5C8A),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          // 컵 입구 (열린 상태일 때만)
          if (shouldShowOpen)
            Positioned(
              top: 0,
              child: Container(
                width: 70,
                height: 15,
                decoration: BoxDecoration(
                  color: Color(0xFF6BA3E8),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: Color(0xFF2E5C8A),
                    width: 1,
                  ),
                ),
              ),
            ),
          // 하이라이트 효과
          Positioned(
            left: 15,
            top: shouldShowOpen ? 20 : 15,
            child: Container(
              width: 3,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget selectNumberItem(int index, bool isSelected, ShellgameState state) {
  final isEnabled = state is ShellgameReady || state is ShellgameWaiting;
  
  return Container(
    width: 105,
    height: 45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: isSelected ? null : Border.all(
        color: isEnabled ? GogoColors.white : GogoColors.gray500
      ),
      color: isSelected 
          ? GogoColors.main600 
          : isEnabled 
              ? GogoColors.black 
              : GogoColors.gray600,
    ),
    child: Text(
      '${index + 1}',
      style: GogoTypography.caption1Semibold.copyWith(
        color: isEnabled ? GogoColors.white : GogoColors.gray500,
      ),
    ),
  );
}

Widget roundItem(int index, bool isSelected) {
  return Container(
    width: 68.6,
    height: 42,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: isSelected ? Border(
        bottom: BorderSide(
          color: GogoColors.white,
          width: 1,
        ),
      ) : null,
    ),
    child: Text(
      '$index 라운드',
      style: GogoTypography.caption2Extrabold.copyWith(
        color: isSelected ? GogoColors.white : GogoColors.gray500,
      ),
    ),
  );
}

Widget _buildSuccessNotification(ShellgameState state) {
  if (state.resultMessage != null && state.earnedPoints != null) {
    final isSuccess = state.isWin == true;
    final pointText = isSuccess ? '${state.earnedPoints}P +' : '${state.earnedPoints?.abs()}P -';
    final pointColor = isSuccess ? GogoColors.success : GogoColors.error;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: GogoColors.gray700.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GogoColors.gray600.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.resultMessage!,
            style: GogoTypography.body3Semibold.copyWith(
              color: GogoColors.white,
            ),
          ),
          Text(
            pointText,
            style: GogoTypography.body3Semibold.copyWith(
              color: pointColor,
            ),
          ),
        ],
      ),
    );
  }
  return const SizedBox.shrink();
}

Widget _buildTimerBar(BuildContext context, ShellgameState state) {
  if (state.isTimerRunning && state.timerSeconds >= 0) {
    final progress = state.timerSeconds / 10.0;
    final isUrgent = state.timerSeconds <= 3;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GogoTypography.body3Semibold.copyWith(
                  color: isUrgent ? GogoColors.error : GogoColors.white,
                ),
                child: const Text('선택하세요!'),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GogoTypography.body3Semibold.copyWith(
                  color: isUrgent ? GogoColors.error : GogoColors.white,
                  fontSize: isUrgent ? 16 : 14,
                ),
                child: Text('${state.timerSeconds}초'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: GogoColors.gray600,
              borderRadius: BorderRadius.circular(4),
            ),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: 0.0, end: progress),
              builder: (context, animatedProgress, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: animatedProgress,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: isUrgent ? GogoColors.error : GogoColors.main600,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: isUrgent ? [
                        BoxShadow(
                          color: GogoColors.error.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ] : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  return const SizedBox.shrink();
}

// 성공 시 다음 라운드 진행 여부를 묻는 모달
class _NextRoundModal extends StatelessWidget {
  final int currentRound;
  final int earnedPoints;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const _NextRoundModal({
    required this.currentRound,
    required this.earnedPoints,
    required this.onYes,
    required this.onNo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6), // 더 투명한 배경
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 질문 텍스트 (컵들 위에 표시)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '다음 라운드에 도전하겠습니까?',
              style: GogoTypography.body1Semibold.copyWith(
                color: GogoColors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 200), // 컵들과 버튼 사이 간격
          
          // YES/NO 버튼들
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              spacing: 24,
              children: [
                // YES 버튼
                Expanded(
                  child: GestureDetector(
                    onTap: onYes,
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          'YES',
                          style: GogoTypography.body1Semibold.copyWith(
                            color: GogoColors.success,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // NO 버튼
                Expanded(
                  child: GestureDetector(
                    onTap: onNo,
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          'NO',
                          style: GogoTypography.body1Semibold.copyWith(
                            color: GogoColors.error,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}