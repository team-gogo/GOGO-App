import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/mini_game/bet_limit_response.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import '../../cointoss/bloc/coin_toss_event.dart';

class MinigameComponent extends StatelessWidget {
  final int point;
  final int ticketsCount;
  final String action;
  final VoidCallback onTap;
  final TextEditingController controller;
  final BetLimitResponse betLimit;
  final bool isSelect;

  const MinigameComponent(
      {required this.point,
      required this.ticketsCount,
      required this.action,
      required this.onTap,
      super.key,
      required this.betLimit,
      required this.isSelect,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "보유 코인",
              style: GogoTypography.body3Extrabold.copyWith(
                color: GogoColors.gray300,
              ),
            ),
            GogoIcons.pointCircle(
              color: GogoColors.white,
            ),
            Expanded(
              flex: 3,
              child: Text(
                '$point',
                style: GogoTypography.body2Semibold.copyWith(
                  color: GogoColors.white,
                ),
              ),
            ),
            Text(
              '티켓',
              style: GogoTypography.body3Semibold.copyWith(
                color: GogoColors.gray300,
              ),
            ),
            GogoIcons.ticket(
              color: GogoColors.white,
            ),
            Text(
              "$ticketsCount",
              style: GogoTypography.body3Semibold.copyWith(
                color: GogoColors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Column(
          spacing: 4,
          children: [
            GogoTextField(
              controller: controller,
              hintText: '포인트를 입력해주세요',
              backgroundColor: GogoColors.gray700,
              keyboardType: TextInputType.number,
              endIcon: GogoIcons.pointCircle(),
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyFormatter()
              ],
            ),
            Row(
              spacing: 8,
              children: [
                GogoIcons.exclamationMarkCircle(
                    color: GogoColors.gray400, width: 16, height: 16),
                Text(
                  '최소 배팅 금액 : ${betLimit.coinToss.minBetPoint}  ㅣ 최대 배팅 금액 : ${betLimit.coinToss.maxBetPoint}',
                  style: GogoTypography.caption3Semibold.copyWith(
                    color: GogoColors.gray500,
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: controller.text.isNotEmpty && isSelect ? onTap : null,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: controller.text.isNotEmpty && isSelect
                  ? GogoColors.main600
                  : GogoColors.gray400,
            ),
            child: Text(
              action,
              style: GogoTypography.body3Semibold.copyWith(
                color: GogoColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
