import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/mini_game/active_game_response.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/router.dart';

class MinigamePlayComponent extends StatelessWidget {
  const MinigamePlayComponent(
      {super.key, required this.activeGameResponse, required this.stageId});

  final int stageId;
  final ActiveGameResponse activeGameResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MinigameSelectButton(
            gameName: '야바위',
            minigameImage: '야바위',
            isActive: activeGameResponse.isYavarweeActive,
            stageId: stageId,
          ),
          MinigameSelectButton(
            gameName: '코인토스',
            minigameImage: '코인토스',
            isActive: activeGameResponse.isCoinTossActive,
            stageId: stageId,
          ),
          MinigameSelectButton(
            gameName: '플린코',
            minigameImage: '플린코',
            isActive: activeGameResponse.isPlinkoActive,
            stageId: stageId,
          ),
        ],
      ),
    );
  }
}

class MinigameSelectButton extends StatelessWidget {
  final String gameName;
  final String minigameImage;
  final bool isActive;
  final int stageId;

  MinigameSelectButton({
    super.key,
    required this.gameName,
    required this.minigameImage,
    required this.isActive,
    required this.stageId,
  });

  Widget _buildIcon(String name, Color color) {
    switch (name) {
      case '야바위':
        return GogoIcons.shellGame(color: color, width: 32, height: 32);
      case '코인토스':
        return GogoIcons.pointCoin(color: color, width: 32, height: 32);
      case '플린코':
        return GogoIcons.plinko(color: color, width: 32, height: 32);
      default:
        return GogoIcons.etc(color: color, width: 32, height: 32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, VoidCallback> _gameOnTap = {
      '야바위': () => PageRouter.gogoPushNamed(PageRouter.yavarwee, stageId),
      '코인토스': () => PageRouter.gogoPushNamed(PageRouter.coinToss, stageId),
      '플린코': () {}, // TODO: 플린코 라우팅 구현
    };
    final Color iconColor = isActive ? GogoColors.white : GogoColors.gray400;
    final Color bgColor = isActive ? GogoColors.main600 : GogoColors.gray700;

    return SizedBox(
      height: 104.sp,
      width: 104.sp,
      child: ElevatedButton(
        onPressed: isActive ? _gameOnTap[minigameImage] : () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(minigameImage, iconColor),
            SizedBox(height: 8),
            Text(
              gameName,
              style: GogoTypography.body3Semibold.copyWith(
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
