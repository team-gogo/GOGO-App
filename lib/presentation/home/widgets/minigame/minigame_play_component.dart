import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/router.dart';

import '../../../../design_system/theme/color.dart';

class MinigamePlayComponent extends StatelessWidget {
  const MinigamePlayComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: MinigameSelectButton.gameIcons.keys.map((game) {
          return MinigameSelectButton(
            gameName: game,
            minigameImage: game,
          );
        }).toList(),
      ),
    );
  }
}

class MinigameSelectButton extends StatelessWidget {
  final String gameName;
  final String minigameImage;

  const MinigameSelectButton({
    required this.gameName,
    required this.minigameImage,
    super.key,
  });

  static final Map<String, Widget> gameIcons = {
    '야바위': GogoIcons.shellGame(color: GogoColors.gray400),
    '코인토스': GogoIcons.pointCircle(color: GogoColors.gray400),
    '플린코': GogoIcons.plinko(color: GogoColors.gray400),
  };

  static final Map<String, VoidCallback> gameOnTap = {
    '야바위': () => PageRouter.router.pushNamed(PageRouter.yavarwee),
    '코인토스': () => PageRouter.router.pushNamed(PageRouter.coinToss),
    '플린코': () {}
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104.sp,
      width: 104.sp,
      child: ElevatedButton(
        onPressed: gameOnTap[minigameImage],
        style: ElevatedButton.styleFrom(
          foregroundColor: GogoColors.main500,
          backgroundColor: GogoColors.gray700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gameIcons[minigameImage]!,
            Text(
              gameName,
              style: GogoTypography.body3Semibold.copyWith(
                color: GogoColors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
