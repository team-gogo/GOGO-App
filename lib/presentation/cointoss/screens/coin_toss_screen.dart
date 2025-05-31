import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/mini_game/bet_limit_response.dart';
import 'package:video_player/video_player.dart';
import '../../../data/models/mini_game/betting/coin_toss_request.dart';
import '../../../design_system/component/button/gogo_default_button.dart';
import '../../../design_system/component/indicator/refresh_indicator.dart';
import '../../../design_system/component/top_bar/gogo_top_bar.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';
import '../../loading/screens/loadaing_page.dart';
import '../bloc/coin_toss_bloc.dart';
import '../bloc/coin_toss_event.dart';
import '../bloc/coin_toss_state.dart';
import '../../minigame/widgets/minigame_component.dart';

class CoinTossScreen extends StatefulWidget {
  const CoinTossScreen({super.key, required this.stageId});

  final int stageId;

  @override
  State<CoinTossScreen> createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> {
  late final CoinTossBloc _bloc;
  late final TextEditingController _pointController;
  VideoPlayerController? _videoPlayerController;
  CoinTossStatus? _bet;
  late BetLimitResponse _betLimitResponse;
  late int _ticketsCount;
  late int _point;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _bloc = CoinTossBloc()
      ..add(GetCoinToss(stageId: widget.stageId, init: true));
    _initializeVideo('assets/media/coin_f.mp4');
    _pointController = TextEditingController()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _bloc.close();
    _videoPlayerController?.removeListener(_onVideoEnd);
    _videoPlayerController?.dispose();
    _pointController.dispose();
    super.dispose();
  }

  void _onVideoEnd() {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.position >=
            _videoPlayerController!.value.duration &&
        _isVideoPlaying) {
      setState(() {
        _isVideoPlaying = false;
      });
    }
  }

  Future<void> _initializeVideo(String path) async {
    _videoPlayerController?.removeListener(_onVideoEnd);
    _videoPlayerController = VideoPlayerController.asset(path);
    await _videoPlayerController?.initialize();
    _videoPlayerController?.setLooping(false);
    _videoPlayerController?.setPlaybackSpeed(2.0);
    _videoPlayerController?.addListener(_onVideoEnd);
    setState(() {});
  }

  Future<void> _playResultVideo(
      CoinTossStatus userBet, CoinTossState result) async {
    final isWin = result is CoinTossBettingSuccess;
    final assetPath = (userBet == CoinTossStatus.FRONT)
        ? (isWin ? 'assets/media/coin_f.mp4' : 'assets/media/coin_b.mp4')
        : (isWin ? 'assets/media/coin_b.mp4' : 'assets/media/coin_f.mp4');
    await _initializeVideo(assetPath);
    await _videoPlayerController?.play();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<CoinTossBloc, CoinTossState>(
        listener: (context, state) async {
          if (state is CoinTossBettingSuccess ||
              state is CoinTossBettingFailure) {
            await _playResultVideo(_bet!, state);
            _bloc.add(GetCoinToss(stageId: widget.stageId));
          }
        },
        builder: (context, state) {
          if (state is CoinTossInitial) {
            return const LoadingPage();
          }
          if (state is CoinTossFailure) {
            return Scaffold(
              body: Center(
                child: Text('오류가 발생했습니다: ${state.error}',
                    style: GogoTypography.body3Semibold
                        .copyWith(color: GogoColors.error)),
              ),
            );
          }
          if (state is CoinTossLoaded) {
            _betLimitResponse = state.betLimitResponse;
            _ticketsCount = state.ticketCountsResponse.coinToss;
            _point = state.pointResponse.point;
          }
          return Scaffold(
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  children: [
                    GogoTopBar(title: '코인 토스', onBackTap: () => context.pop()),
                    GogoRefreshIndicator(
                      onRefresh: () async =>
                          _bloc.add(GetCoinToss(stageId: widget.stageId)),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 36),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Transform.scale(
                                scale: 1.5,
                                child: Transform.translate(
                                  offset: const Offset(0, -80),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: (_videoPlayerController
                                                ?.value.isInitialized ??
                                            false)
                                        ? VideoPlayer(_videoPlayerController!)
                                        : Container(
                                            color: GogoColors.black,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: GogoDefaultButton(
                                    border: _bet == CoinTossStatus.FRONT
                                        ? null
                                        : Border.all(color: GogoColors.white),
                                    color: _bet == CoinTossStatus.FRONT
                                        ? GogoColors.main600
                                        : Colors.transparent,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    text: '앞면',
                                    onTap: () {
                                      if (_isVideoPlaying) return;
                                      setState(
                                          () => _bet = CoinTossStatus.FRONT);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: GogoDefaultButton(
                                    border: _bet == CoinTossStatus.BACK
                                        ? null
                                        : Border.all(color: GogoColors.white),
                                    color: _bet == CoinTossStatus.BACK
                                        ? GogoColors.main600
                                        : Colors.transparent,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    text: '뒷면',
                                    onTap: () {
                                      if (_isVideoPlaying) return;
                                      setState(
                                          () => _bet = CoinTossStatus.BACK);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 36),
                            MinigameComponent(
                              betLimit: _betLimitResponse,
                              point: _point,
                              ticketsCount: _ticketsCount,
                              action: '뒤집기',
                              controller: _pointController,
                              onTap: () {
                                if (_isVideoPlaying) return;

                                final inputText =
                                    _pointController.text.replaceAll(',', '');
                                final betAmount = int.tryParse(inputText) ?? 0;

                                if (betAmount <
                                    _betLimitResponse.coinToss.minBetPoint!) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '최소 배팅금액은 ${_betLimitResponse.coinToss.minBetPoint}원 입니다.')),
                                  );
                                  return;
                                }

                                if (betAmount >
                                    _betLimitResponse.coinToss.maxBetPoint!) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '최대 배팅금액은 ${_betLimitResponse.coinToss.maxBetPoint}원 입니다.')),
                                  );
                                  return;
                                }

                                if (_bet != null ||
                                    (_videoPlayerController!
                                            .value.isInitialized &&
                                        _videoPlayerController!
                                            .value.isCompleted)) {
                                  setState(() {
                                    _isVideoPlaying = true;
                                  });
                                  _bloc.add(BettingCoinToss(
                                    stageId: widget.stageId,
                                    amount: betAmount,
                                    bet: _bet!,
                                  ));
                                }
                              },
                              isSelect: !_isVideoPlaying &&
                                  (_bet != null ||
                                      (_videoPlayerController!
                                              .value.isInitialized &&
                                          _videoPlayerController!
                                              .value.isCompleted)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
