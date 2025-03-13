import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigamePlayComponent extends StatelessWidget {
  final VoidCallback buttononPressed;
  final bool selectedminigame; // 미니게임이 선택이 되면 true, 안되면 false

  const MinigamePlayComponent({
    super.key,
    required this.buttononPressed,
    this.selectedminigame = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 343.w,
          height: 24.h,
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
                      width: 8.w,
                    ),
                    Text(
                      "미니게임",
                      maxLines: 1,
                      style: GogoTypography.body2Extrabold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "더보기",
                      maxLines: 1,
                      style: GogoTypography.caption1Semibold.copyWith(
                        color: GogoColors.gray500,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
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
          height: 16.h,
        ),
        Container(
          width: 343.w,
          height: 183.h,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: GogoColors.gray700,
          ),
          child: Column(
            children: [
              Container(
                width: 309.w,
                height: 95.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MinigameSelectButton(
                      gameName: "야바위",
                      minigameImage: GogoIcons.shellGame(
                        color: GogoColors.gray400,
                      ),
                      onPressed: buttononPressed,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    MinigameSelectButton(
                      gameName: "코인토스",
                      minigameImage: GogoIcons.gameIcon(
                        color: GogoColors.gray400,
                      ),
                      onPressed: buttononPressed,
                    ),
                    SizedBox(
                      width: 8.w,
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
                height: 12.h,
              ),
              Container(
                width: 309.w,
                height: 48.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
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
                        maxLines: 1,
                        style: GogoTypography.caption1Semibold.copyWith(
                          color: Colors.white,
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
    return Container(
      width: 95.w,
      height: 95.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            GogoColors.gray600,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            minigameImage,
            SizedBox(
              height: 10.h,
            ),
            Text(
              gameName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: GogoTypography.body3Semibold
                  .copyWith(color: GogoColors.gray400),
            ),
          ],
        ),
      ),
    );
  }
}
