import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/stage/create_stage/game.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/%20team_application/widget/game_widget.dart';

class TeamApplicationScreen extends StatelessWidget {
  final int stageId;
  final bool isManger;
  TeamApplicationScreen({super.key, required this.stageId, required this.isManger});

  final List<Game> matches = [
    Game(
      category: GameType.BADMINTON,
      name: '경기 이름',
      system: GameSystem.FULL_LEAGUE,
      teamMinCapacity: 2,
      teamMaxCapacity: 2,
    ),
    Game(
      category: GameType.VOLLEY_BALL,
      name: '경기 이름',
      system: GameSystem.FULL_LEAGUE,
      teamMinCapacity: 2,
      teamMaxCapacity: 2,
    ),
    Game(
      category: GameType.BASKET_BALL,
      name: '경기 이름',
      system: GameSystem.FULL_LEAGUE,
      teamMinCapacity: 2,
      teamMaxCapacity: 2,
    ),
    Game(
      category: GameType.ETC,
      name: '경기 이름',
      system: GameSystem.FULL_LEAGUE,
      teamMinCapacity: 2,
      teamMaxCapacity: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
              child: GogoTopBar(title: '돌아가기', onBackTap: () {}),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '스테이지 이름 경기들',
                          style: GogoTypography.caption1Extrabold
                              .copyWith(color: GogoColors.white),
                        ),
                        Row(
                          spacing: 12.w,
                          children: [
                            GogoTagComponent(
                              color: GogoColors.gray400,
                              text: '확정하기',
                              icon: GogoIcons.check(
                                color: GogoColors.gray400,
                              ),
                            ),
                            GogoTagComponent(
                              color: GogoColors.main500,
                              text: '필터',
                              icon: GogoIcons.filter(
                                color: GogoColors.main500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 16.h,
                          children: List.generate(matches.length, (index) {
                            final Game game = matches[index];
                            return GameWidget(
                              game: game,
                              isManger: true,
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
