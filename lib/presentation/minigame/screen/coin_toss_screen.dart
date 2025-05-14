import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';
import 'package:video_player/video_player.dart';

class CoinTossScreen extends StatefulWidget {
  const CoinTossScreen({super.key});

  @override
  State<CoinTossScreen> createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> {
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _pointController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/media/coin_f.mp4')..initialize();
    _videoPlayerController.setPlaybackSpeed(2.0);
  }

  _runVideo() {
    _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: SingleChildScrollView(
            child: Column(
              spacing: 36,
              children: [
                GogoTopBar(
                  title: '코인 토스',
                  onBackTap: () {},
                ),
                Column(
                  spacing: 24,
                  children: [
                    ClipRect(
                      child: Transform.scale(
                        scale: 1.5,
                        child: Transform.translate(
                          offset: Offset(0, -80),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                    color: GogoColors.white, width: 1),
                              ),
                              child: Text(
                                '앞면',
                                style: GogoTypography.caption1Semibold
                                    .copyWith(color: GogoColors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border:
                                  Border.all(color: GogoColors.white, width: 1),
                            ),
                            child: Text(
                              '뒷면',
                              style: GogoTypography.caption1Semibold
                                  .copyWith(color: GogoColors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                MinigameComponent(
                  point: 1,
                  ticketsCount: 1,
                  action: '뒤집기',
                  controller: _pointController,
                  onTap: _runVideo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
