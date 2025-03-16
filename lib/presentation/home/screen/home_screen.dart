import 'package:flutter/material.dart';
import '../../../design_system/component/tag/tag_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../widgets/match_card/match_card_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TagComponent(
                tagState: TagState.isSelected,
                color: GogoColors.main500,
                icon: GogoIcons.volleyball(),
                text: "배구"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MatchCardComponent(
                    time: TagComponent.small(
                      color: GogoColors.success,
                      text: "12:00",
                      icon: GogoIcons.alarm(
                        color: GogoColors.success,
                        width: 12,
                        height: 12,
                      ),
                    ),
                    round: TagComponent.small(
                      color: GogoColors.white,
                      text: "12강",
                      icon: GogoIcons.trophy(
                          color: GogoColors.white, width: 12, height: 12),
                    ),
                    event: TagComponent.small(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: GogoColors.main500,
                      text: "배드민턴",
                      icon: GogoIcons.volleyball(
                          color: GogoColors.main500, width: 12, height: 12),
                    ),
                    point: '10000P',
                    teamA: "A",
                    teamB: 'B',
                  ),EndedMatchCardComponent(
                    round: TagComponent.small(
                      color: GogoColors.white,
                      text: "12강",
                      icon: GogoIcons.trophy(
                          color: GogoColors.white, width: 12, height: 12),
                    ),
                    event: TagComponent.small(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: GogoColors.main500,
                      text: "배드민턴",
                      icon: GogoIcons.volleyball(
                          color: GogoColors.main500, width: 12, height: 12),
                    ),
                    point: '10000P',
                    winner: "A",
                    earnedPoint: -1000,
                    isPredictionSuccess: false,
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
