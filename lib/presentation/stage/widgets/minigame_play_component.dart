import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';

class MinigamePlayComponent extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final VoidCallback buttononPressed;
  final bool selectedminigame; // 미니게임이 선택이 되면 true, 안되면 false
  final EdgeInsets padding;
  final double spacing;

  const MinigamePlayComponent({
    super.key,
    this.width = 343,
    this.height = 232,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    required this.buttononPressed,
    this.selectedminigame = false,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 17),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width,
          height: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GogoIcons.arcade(
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: spacing,
                    ),
                    Text(
                      "미니게임",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SUIT",
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "더보기",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "SUIT",
                        fontWeight: FontWeight.w600,
                        color: GogoColors.gray500,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GogoIcons.chevronRight(
                      color: GogoColors.gray500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: width,
          height: 183,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: GogoColors.gray700,
          ),
          child: Column(
            children: [
              Container(
                width: 309,
                height: 95,
                child: Row(
                  children: [
                    MinigameSelectButton(
                      gameName: "야바위",
                      minigameImage: GogoIcons.shellGame(
                        color: GogoColors.gray400,
                      ),
                      onPressed: buttononPressed,
                    ),
                    SizedBox(
                      width: spacing,
                    ),
                    MinigameSelectButton(
                      gameName: "코인토스",
                      minigameImage: GogoIcons.pointCircle(
                        color: GogoColors.gray400,
                      ),
                      onPressed: buttononPressed,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MinigameSelectButton(
                      gameName: "플린코",
                      minigameImage: GogoIcons.plinko(
                        color: GogoColors.gray400,
                      ),
                      onPressed: buttononPressed,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 309,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      GogoColors.gray400,
                    ),
                  ),
                  onPressed: buttononPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "게임 하기",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "SUIT",
                          fontWeight: FontWeight.w600,
                          color: GogoColors.white,
                        ),
                      ),
                      GogoIcons.chevronRight(
                        color: GogoColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MinigameSelectButton extends StatelessWidget {
  final String gameName;
  final Widget minigameImage;
  final VoidCallback onPressed;

  const MinigameSelectButton({
    required this.gameName,
    required this.minigameImage,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: 95,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            GogoColors.gray600,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            minigameImage,
            SizedBox(
              height: 10,
            ),
            Text(
              gameName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GogoColors.gray400,
                fontFamily: "SUIT",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
