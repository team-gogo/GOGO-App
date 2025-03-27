import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_state.dart';

class MinigameDescriptionPopup extends StatelessWidget {
  final String minigameName;

  const MinigameDescriptionPopup({
    required this.minigameName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinigameDescriptionBloc, MinigameDescriptionState>(
        builder: (context, state) {
      String selectMinigame = state is MinigameDescriptionUpdated
          ? state.minigameName
          : minigameName;

      List<String> minigameExplanation = [
        '3개의 컵 중 하나의 컵에 공을 숨기고 섞습니다.\n공이 들어가있는 컵을 정확히 찾으면 다음 라운드로 진행합니다!\n성공할때마다 X1.1, X1.3, X1.5, X2, X5\n배율로 포인트가 지급됩니다.',
        '앞, 뒷변에 포인트를 배팅하고 예측에 성공하면 포인트를 2배로 얻습니다!',
        '플레이어가 공을 떨어뜨리면 핀에 부딪히며 랜덤한 경로로 내려갑니다.\n최종적으로 도착한 슬롯에 적혀진 만큼의 보상을 얻습니다.'
      ];

      String changDescription(String selectMinigame) {
        if (selectMinigame == '야바위') {
          return minigameExplanation[0];
        } else if (selectMinigame == '코인토스') {
          return minigameExplanation[1];
        } else if (selectMinigame == '플린코') {
          return minigameExplanation[2];
        } else {
          return '';
        }
      }

      return Dialog(
        backgroundColor: GogoColors.gray700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GogoTagComponent(
                    textStyle: GogoTypography.caption1Semibold.copyWith(
                      fontSize: 11,
                    ),
                    color: GogoColors.main500,
                    text: '야바위',
                    tagState: selectMinigame == '야바위',
                    icon: GogoIcons.shellGame(
                      color: selectMinigame == '야바위'
                          ? GogoColors.white
                          : GogoColors.main500,
                      width: 12,
                      height: 12,
                    ),
                    ontap: () {
                      context
                          .read<MinigameDescriptionBloc>()
                          .add(ChangeCategory(minigameName: '야바위'));
                    },
                  ),
                  GogoTagComponent(
                    textStyle: GogoTypography.caption1Semibold.copyWith(
                      fontSize: 11,
                    ),
                    color: GogoColors.main500,
                    text: '코인토스',
                    icon: GogoIcons.pointCoin(
                      color: selectMinigame == '코인토스'
                          ? GogoColors.white
                          : GogoColors.main500,
                      width: 12,
                      height: 12,
                    ),
                    tagState: selectMinigame == '코인토스',
                    ontap: () {
                      context
                          .read<MinigameDescriptionBloc>()
                          .add(ChangeCategory(minigameName: '코인토스'));
                    },
                  ),
                  GogoTagComponent(
                    textStyle: GogoTypography.caption1Semibold.copyWith(
                      fontSize: 11,
                    ),
                    color: GogoColors.main500,
                    text: '플린코',
                    icon: GogoIcons.plinko(
                      color: selectMinigame == '플린코'
                          ? GogoColors.white
                          : GogoColors.main500,
                      width: 12,
                      height: 12,
                    ),
                    tagState: selectMinigame == '플린코',
                    ontap: () {
                      context
                          .read<MinigameDescriptionBloc>()
                          .add(ChangeCategory(minigameName: '플린코'));
                    },
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
                  changDescription(selectMinigame),
                  style: GogoTypography.caption2Semibold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
