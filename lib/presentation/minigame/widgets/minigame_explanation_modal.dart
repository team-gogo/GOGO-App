import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigameExplanationModal extends StatelessWidget {
  final String minigameName;

  const MinigameExplanationModal({
    required this.minigameName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> minigameExplanation = [
      '3개의 컵 중 하나의 컵에 공을 숨기고 섞습니다.\n 공이 들어가있는 컵을 정확히 찾으면 다음 라운드로 진행합니다!\n성공할때마다 X1.1, X1.3, X1.5, X2, X5\n배율로 포인트가 지급됩니다.'
    ];

    return Dialog(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '게임 설명',
                style: GogoTypography.body2Semibold.copyWith(
                  color: GogoColors.white,
                ),
              ),
              GogoIcons.x(
                onTap: () {
                  Navigator.pop(context);
                },
                color: GogoColors.white,
              ),
            ],
          ),
          Row(
            children: [
              GogoTagComponent(
                color: GogoColors.main500,
                text: '야바위',
                icon: GogoIcons.shellGame(),
                tagState: minigameName == '야바위',
              ),
              GogoTagComponent(
                color: GogoColors.main500,
                text: '코인토스',
                icon: GogoIcons.plinko(),
                tagState: minigameName == '코인토스',
              ),
              GogoTagComponent(
                color: GogoColors.main500,
                text: '플린코',
                icon: GogoIcons.plinko(),
                tagState: minigameName == '플린린코',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
