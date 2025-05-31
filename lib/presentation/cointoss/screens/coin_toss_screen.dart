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
  bool _isPlayingAnimation = false;

  late BetLimitResponse _betLimitResponse;
  late int _ticketsCount;
  late int _point;

  @override
  void initState() {
    super.initState();
    _bloc = CoinTossBloc()..add(GetCoinToss(stageId: widget.stageId));
    _pointController = TextEditingController()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _bloc.close();
    _videoPlayerController?.dispose();
    _pointController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(String path, {bool autoPlay = true}) async {
    final controller = VideoPlayerController.asset(path);
    await controller.initialize();
    controller.setLooping(false);
    controller.setPlaybackSpeed(2.0);
    if (autoPlay) controller.play();
    controller.addListener(() async {
      if (controller.value.position >= controller.value.duration &&
          !_isPlayingAnimation) {
        setState(() => _isPlayingAnimation = true);
        _bloc.add(GetCoinToss(stageId: widget.stageId));
      }
    });
    setState(() {
      _videoPlayerController?.dispose();
      _videoPlayerController = controller;
      _isPlayingAnimation = false;
    });
  }

  Future<void> _playResultVideo(
      CoinTossStatus userBet, CoinTossState result) async {
    _point = _point - int.parse(_pointController.text.replaceAll(',', ''));
    final isWin = result is CoinTossBettingSuccess;
    final assetPath = (userBet == CoinTossStatus.FRONT)
        ? (isWin ? 'assets/media/coin_f.mp4' : 'assets/media/coin_b.mp4')
        : (isWin ? 'assets/media/coin_b.mp4' : 'assets/media/coin_f.mp4');
    await _initializeVideo(assetPath, autoPlay: true);
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
                                        : Container(color: Colors.black),
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
                                    onTap: () => setState(
                                        () => _bet = CoinTossStatus.FRONT),
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
                                    onTap: () => setState(
                                        () => _bet = CoinTossStatus.BACK),
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
                                if (_bet != null) {
                                  _bloc.add(BettingCoinToss(
                                    stageId: widget.stageId,
                                    amount: _pointController.text.isEmpty
                                        ? 0
                                        : int.parse(_pointController.text
                                            .replaceAll(',', '')),
                                    bet: _bet!,
                                  ));
                                }
                              },
                              isSelect: _bet != null && _isPlayingAnimation,
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
