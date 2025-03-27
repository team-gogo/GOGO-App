import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigameDescriptionPopup extends StatelessWidget {
  final String minigameName;

  const MinigameDescriptionPopup({
    required this.minigameName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> minigameExplanation = [
      '3개의 컵 중 하나의 컵에 공을 숨기고 섞습니다.\n공이 들어가있는 컵을 정확히 찾으면 다음 라운드로 진행합니다!\n성공할때마다 X1.1, X1.3, X1.5, X2, X5\n배율로 포인트가 지급됩니다.',
      '앞, 뒷변에 포인트를 배팅하고 예측에 성공하면 포인트를 2배로 얻습니다!',
      '플레이어가 공을 떨어뜨리면 핀에 부딪히며 랜덤한 경로로 내려갑니다.\n최종적으로 도착한 슬롯에 적혀진 만큼의 보상을 얻습니다.'
    ];

    String minigameExplanationSelect() {
      int n = 0;
      if (minigameName == '야바위') {
        n = 0;
      }
      if (minigameName == '코인토스') {
        n = 1;
      }
      if (minigameName == '플린코') {
        n = 2;
      }
      return minigameExplanation[n];
    }

    return Dialog(
      backgroundColor: GogoColors.gray700,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 15.r),
        child: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '게임 설명',
                  style: GogoTypography.body2Semibold.copyWith(
                    color: GogoColors.white,
                    fontWeight: FontWeight.w800,
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
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                GogoTagComponent(
                  color: GogoColors.main500,
                  text: '야바위',
                  tagState: minigameName == '야바위',
                  icon: GogoIcons.shellGame(
                    color: minigameName == '야바위'
                        ? GogoColors.white
                        : GogoColors.main500,
                    width: 12,
                    height: 12,
                  ),
                  textStyle: GogoTypography.caption1Semibold.copyWith(
                    fontSize: 11,
                  ),
                ),
                GogoTagComponent(
                  color: GogoColors.main500,
                  text: '코인토스',
                  icon: GogoIcons.pointCoin(
                    color: minigameName == '코인토스'
                        ? GogoColors.white
                        : GogoColors.main500,
                    width: 12,
                    height: 12,
                  ),
                  tagState: minigameName == '코인토스',
                  textStyle: GogoTypography.caption1Semibold.copyWith(
                    fontSize: 11,
                  ),
                ),
                GogoTagComponent(
                  color: GogoColors.main500,
                  text: '플린코',
                  icon: GogoIcons.plinko(
                    color: minigameName == '플린코'
                        ? GogoColors.white
                        : GogoColors.main500,
                    width: 12,
                    height: 12,
                  ),
                  tagState: minigameName == '플린코',
                  textStyle: GogoTypography.caption1Semibold.copyWith(
                    fontSize: 11,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: GogoColors.gray600,
              ),
              child: Text(
                minigameExplanationSelect(),
                style: GogoTypography.caption2Semibold.copyWith(
                  color: GogoColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
