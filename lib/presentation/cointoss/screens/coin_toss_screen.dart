import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/mini_game/bet_limit_response.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/indicator/refresh_indicator.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/presentation/cointoss/bloc/coin_toss_bloc.dart';
import 'package:gogo_app/presentation/cointoss/bloc/coin_toss_event.dart';
import 'package:gogo_app/presentation/cointoss/bloc/coin_toss_state.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';
import 'package:video_player/video_player.dart';
import '../../../data/models/mini_game/betting/coin_toss_request.dart';

class CoinTossScreen extends StatefulWidget {
  const CoinTossScreen({super.key, required this.stageId});

  final int stageId;

  @override
  State<CoinTossScreen> createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> {
  VideoPlayerController? videoPlayerController;
  late BetLimitResponse betLimit;
  late int point;
  late int ticketCounts;

  Future<void> _initializeAndPlay(String assetPath, double speed) async {
    final controller = VideoPlayerController.asset(assetPath);
    await controller.initialize();
    controller.setPlaybackSpeed(speed);
    await videoPlayerController?.pause();
    await videoPlayerController?.dispose();
    setState(() {
      videoPlayerController = controller;
    });
  }

  Future<void> _playVideo(CoinTossStatus bet, bool success) async {
    final isFront = bet == CoinTossStatus.FRONT;
    final video = (isFront == success)
        ? 'assets/media/coin_f.mp4'
        : 'assets/media/coin_b.mp4';
    await _initializeAndPlay(video, 2.0);
  }

  final TextEditingController _pointController = TextEditingController();
  CoinTossStatus? _bet;

  @override
  void initState() {
    super.initState();
    _initializeAndPlay('assets/media/coin_f.mp4', 2.0);
    _pointController.clear();
    _pointController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    _pointController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CoinTossBloc()..add(GetCoinToss(stageId: widget.stageId)),
      child:
          BlocBuilder<CoinTossBloc, CoinTossState>(builder: (context, state) {
        if (state is CoinTossLoading) {
          return LoadingPage();
        } else if (state is CoinTossLoaded || state is CoinTossBetting) {
          if (state is CoinTossLoaded) {
            betLimit = state.betLimitResponse;
            point = state.pointResponse.point;
            ticketCounts = state.ticketCountsResponse.coinToss;
          }
          if (state is CoinTossBetting) {
            _playVideo(_bet!, state.response.result);
          }
          return Scaffold(
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  children: [
                    GogoTopBar(
                      title: '코인 토스',
                      onBackTap: () => context.pop(context),
                    ),
                    GogoRefreshIndicator(
                      onRefresh: () async => context.read<CoinTossBloc>().add(
                            GetCoinToss(stageId: widget.stageId),
                          ),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          spacing: 36,
                          children: [
                            Column(
                              spacing: 24,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Transform.scale(
                                    scale: 1.5,
                                    child: Transform.translate(
                                      offset: Offset(0, -80),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: videoPlayerController != null &&
                                                videoPlayerController!
                                                    .value.isInitialized
                                            ? VideoPlayer(
                                                videoPlayerController!)
                                            : Container(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  spacing: 15,
                                  children: [
                                    Expanded(
                                      child: GogoDefaultButton(
                                        border: _bet == CoinTossStatus.FRONT
                                            ? null
                                            : Border.all(
                                                color: GogoColors.white),
                                        color: _bet == CoinTossStatus.FRONT
                                            ? GogoColors.main600
                                            : Colors.transparent,
                                        width: double.infinity,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        text: '앞면',
                                        onTap: () => setState(() {
                                          _bet = CoinTossStatus.FRONT;
                                        }),
                                      ),
                                    ),
                                    Expanded(
                                      child: GogoDefaultButton(
                                        border: _bet == CoinTossStatus.BACK
                                            ? null
                                            : Border.all(
                                                color: GogoColors.white),
                                        color: _bet == CoinTossStatus.BACK
                                            ? GogoColors.main600
                                            : Colors.transparent,
                                        width: double.infinity,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        text: '뒷면',
                                        onTap: () => setState(() {
                                          _bet = CoinTossStatus.BACK;
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            MinigameComponent(
                              betLimit: betLimit,
                              point: point,
                              ticketsCount: ticketCounts,
                              action: '뒤집기',
                              controller: _pointController,
                              onTap: () => context.read<CoinTossBloc>().add(
                                  BettingCoinToss(
                                      stageId: widget.stageId,
                                      amount: _pointController.text.isEmpty
                                          ? 0
                                          : int.parse(_pointController.text
                                              .replaceAll(',', '')),
                                      bet: _bet!)),
                              isSelect: _bet != null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(body: Center(child: Text('오류가 발생했습니다')));
        }
      }),
    );
  }
}
