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
    // 섞는 중이면 불가
    if (state.isShuffling) return false;
    
    // 티켓이 없으면 불가
    if (widget.ticketsCount <= 0) return false;
    
    // 라운드 상태일 때는 베팅 금액 없이도 시작 가능 (승리 후 다음 라운드)
    if (state is ShellgameRound) return true;
    
    // 베팅 금액 검증
    final betText = _betController.text;
    if (betText.isEmpty) return false;
    
    final betAmount = int.tryParse(betText);
    if (betAmount == null) return false;
    if (betAmount <= 0) return false;
    if (betAmount > widget.point) return false;
    
    return true;
  }
  
  String? _getValidationError(ShellgameState state) {
    if (state.isShuffling) return '섞는 중입니다';
    if (widget.ticketsCount <= 0) return '티켓이 부족합니다';
    
    final betText = _betController.text;
    if (betText.isEmpty) return '베팅 금액을 입력하세요';
    
    final betAmount = int.tryParse(betText);
    if (betAmount == null) return '올바른 숫자를 입력하세요';
    if (betAmount <= 0) return '0보다 큰 금액을 입력하세요';
    if (betAmount > widget.point) return '보유 포인트를 초과했습니다';
    
    return null;
  }
  
  void _startShuffling(BuildContext context) {
    final bloc = context.read<ShellGameBloc>();
    final currentState = bloc.state;
    
    // 베팅 금액 검증 및 저장
    final betText = _betController.text;
    int betAmount;
    
    if (currentState is ShellgameRound && _initialBetAmount != null) {
      betAmount = _initialBetAmount!;
    } else {
      betAmount = int.tryParse(betText) ?? 0;
      if (betAmount <= 0 || betAmount > widget.point) {
        return;
      }
      _initialBetAmount = betAmount;
    }
    
    List<int> currentOrder = [0, 1, 2];
    int ballPosition = 0;
    int actualMoves = 0;
    
    // 라운드별 속도 설정
    int speed = switch (currentState.round) {
      1 => 500,
      2 => 400,
      3 => 300,
      4 => 250,
      _ => 150,
    };
    
    bloc.add(StartShuffle());
    
    Timer.periodic(Duration(milliseconds: speed), (timer) {
      // 두 개의 다른 위치를 무작위로 선택하여 교환
      int index1 = math.Random().nextInt(3);
      int index2;
      
      do {
        index2 = math.Random().nextInt(3);
      } while (index1 == index2);
      
      // 컵 위치 교환
      int temp = currentOrder[index1];
      currentOrder[index1] = currentOrder[index2];
      currentOrder[index2] = temp;
      
      // 공 위치 업데이트
      if (currentOrder[index1] == ballPosition) {
        ballPosition = index1;
      } else if (currentOrder[index2] == ballPosition) {
        ballPosition = index2;
      }
      
      bloc.add(UpdateCupOrder(cupOrder: List<int>.from(currentOrder)));
      actualMoves++;
      
      // 15번 움직인 후 종료
      if (actualMoves >= 15) {
        timer.cancel();
        int finalBallPosition = currentOrder.indexOf(0);
        bloc.add(EndShuffle(ballPosition: finalBallPosition));
        
        // 타이머 시작
        bloc.add(StartTimer());
        _startCountdown(context);
      }
    });
  }
  
  int _getShuffleSpeed(int round) {
    // 라운드별 속도 (밀리초, 숫자가 작을수록 빠름)
    switch (round) {
      case 1: return 500; // 0.5초
      case 2: return 400; // 0.4초
      case 3: return 300; // 0.3초
      case 4: return 200; // 0.2초
      case 5: return 150; // 0.15초
      default: return 500;
    }
  }
  
  double _getRoundMultiplier(int round) {
    // 라운드별 배수
    switch (round) {
      case 1: return 1.1;
      case 2: return 1.2;
      case 3: return 1.5;
      case 4: return 2.5;
      case 5: return 5.0;
      default: return 1.1;
    }
  }
  
  void _startCountdown(BuildContext context) async {
    for (int i = 9; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) {
        final currentState = context.read<ShellGameBloc>().state;
        if (currentState is ShellgameWaiting) {
          context.read<ShellGameBloc>().add(UpdateTimer(seconds: i));
        } else {
          break; // 사용자가 이미 선택했으면 타이머 중단
        }
      }
    }
    
    // 타이머 종료
    if (context.mounted) {
      final currentState = context.read<ShellGameBloc>().state;
      if (currentState is ShellgameWaiting) {
        context.read<ShellGameBloc>().add(TimeOut());
      }
    }
  }
  
  void _checkResult(BuildContext context, ShellgameState state) {
    if ((state is ShellgameReady || state is ShellgameWaiting) && state.playSelect != -1) {
      final isWin = state.ballPosition == state.playSelect;
      
      final betAmount = _initialBetAmount ?? 0;
      if (betAmount <= 0) {
        return;
      }
      
      final currentRound = state.round;
      final multiplier = _getRoundMultiplier(currentRound);
      
      if (isWin) {
        final earnedPoints = (betAmount * multiplier).round();
        
        if (currentRound >= 5) {
          _initialBetAmount = null;
        }
        
        context.read<ShellGameBloc>().add(NextRound(
          isWin: true,
          earnedScore: earnedPoints,
        ));
      } else {
        context.read<ShellGameBloc>().add(NextRound(
          isWin: false,
          earnedScore: betAmount,
        ));
        
        _initialBetAmount = null;
      }
      
      // 3초 후 알림 제거
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          context.read<ShellGameBloc>().add(ClearResult());
        }
      });
    }
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
                       previous.timerSeconds != current.timerSeconds;
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
                                          context.read<ShellGameBloc>().add(PlaySelect(select: index));
                                          // 선택 후 잠시 대기하고 결과 확인
                                          Future.delayed(const Duration(milliseconds: 500), () {
                                            _checkResult(context, context.read<ShellGameBloc>().state);
                                          });
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
                    if (state.resultMessage != null && state.earnedPoints != null)
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: _buildSuccessNotification(state),
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
        
        // 컵 가운데 정렬을 위한 위치 계산
        double leftPosition = 10.0 + positionIndex * 95.0;
        
        // 컵 상태 결정
        bool shouldShowOpen = false;
        bool showBall = false;
        
        if (state is ShellgameReady) {
          if (state.playSelect == -1) {
            // 섞기 전 공 보여주기
            shouldShowOpen = state.ballPosition == cupIndex;
            showBall = shouldShowOpen;
          } else {
            // 선택 후 결과 보여주기
            shouldShowOpen = positionIndex == state.playSelect;
            if (shouldShowOpen) {
              showBall = positionIndex == state.ballPosition;
            }
          }
        }
        
        return AnimatedPositioned(
          duration: Duration(milliseconds: state.isShuffling ? 250 : 400),
          curve: state.isShuffling ? Curves.easeOut : Curves.easeInOut,
          left: leftPosition,
          top: 0,
          child: Container(
            width: 70,
            height: 90,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 컵 몸체 (공도 함께 표시)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: 60,
                    decoration: BoxDecoration(
                      color: shouldShowOpen ? GogoColors.gray500 : GogoColors.gray600,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border: Border.all(
                        color: positionIndex == state.playSelect ? GogoColors.main600 : GogoColors.white, 
                        width: 2
                      ),
                      boxShadow: positionIndex == state.playSelect ? [
                        BoxShadow(
                          color: GogoColors.main600.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ] : null,
                    ),
                    child: showBall 
                      ? Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: GogoColors.main600,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                  ),
                  // 컵 뚜껑 (닫힌 상태일 때만)
                  if (!shouldShowOpen)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 55,
                      height: 8,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: GogoColors.gray400,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: GogoColors.white, width: 1),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
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
        color: GogoColors.gray700,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GogoColors.gray600),
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