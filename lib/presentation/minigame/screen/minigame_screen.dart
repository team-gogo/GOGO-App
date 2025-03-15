import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_play_component.dart';

class MinigameScreen extends StatelessWidget {
  const MinigameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            MinigameTopBar(
              height: 32.h,
              icon: GogoIcons.arcade(
                color: GogoColors.white,
              ),
              text: "게임",
            ),
            MinigameSelectComponent(
              gameIcon: GogoIcons.shellGame(
                width: 48,
                height: 48,
                color: GogoColors.white,
              ),
              gameName: "야바위",
            ),
            MinigameSelectComponent(
              gameIcon: GogoIcons.shellGame(
                width: 48,
                height: 48,
                color: GogoColors.white,
              ),
              gameName: "야바위",
            ),
            MinigameSelectComponent(
              gameIcon: GogoIcons.shellGame(
                width: 48,
                height: 48,
                color: GogoColors.white,
              ),
              gameName: "야바위",
            ),
          ],
        ),
      ),
    );
  }
}

class MinigameSelectComponent extends StatelessWidget {
  final double width;
  final double height;
  final Widget gameIcon;
  final String gameName;

  const MinigameSelectComponent({
    super.key,
    this.width = 343,
    this.height = 143,
    required this.gameIcon,
    required this.gameName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: GogoColors.gray700,
              borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              Center(
                child: Column(
                  spacing: 16,
                  children: [
                    gameIcon,
                    Text(
                      gameName,
                      style: GogoTypography.body1Semibold.copyWith(
                        color: GogoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 0,
                  child: GogoIcons.questionMarkCircle(
                    onTap: () {},
                    color: GogoColors.gray500,
                  )),
            ],
          ),
        ),
        Container(
          width: width,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: GogoColors.main600,
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              "게임하기",
              style: GogoTypography.caption1Semibold.copyWith(
                color: GogoColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MinigameTopBar extends StatelessWidget {
  final double width;
  final double height;
  final Widget icon;
  final String text;

  const MinigameTopBar({
    this.width = 343,
    required this.height,
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          Container(
            width: 67.w,
            height: height,
            child: Row(
              spacing: 8.w,
              children: [
                icon,
                Text(
                  text,
                  style: GogoTypography.body2Extrabold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
