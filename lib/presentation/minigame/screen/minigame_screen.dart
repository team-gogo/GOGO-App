import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigameScreen extends StatelessWidget {
  const MinigameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
    this.height = 209,
    required this.gameIcon,
    required this.gameName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              Column(
                spacing: 16,
                children: [
                  gameIcon,
                  Text(
                    gameName,
                    style: GogoTypography.body1Semibold,
                  ),
                ],
              ),
              Positioned(
                  child: GogoIcons.questionMarkCircle(
                onTap: () {},
                color: GogoColors.gray500,
              )),
            ],
          ),
        )
      ],
    );
  }
}
