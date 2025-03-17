import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';

class MinigameCointossScreen extends StatelessWidget {
  const MinigameCointossScreen({super.key});

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
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 320.h,
                      decoration: BoxDecoration(
                        color: GogoColors.gray700,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: CircleAvatar(),
                    ),
                    Row(
                      spacing: 15,
                      children: [
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
                              '앞면',
                              style: GogoTypography.caption1Semibold
                                  .copyWith(color: GogoColors.white),
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
                MinigameComponent(point: 1, ticketsCount: 1, action: 'asdf')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
