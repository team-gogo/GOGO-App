import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MinigameComponent extends StatelessWidget {
  final double width;
  final int point;
  final int ticketsCount;
  final String action;
  final TextEditingController controller;

  const MinigameComponent({
    this.width = 343,
    required this.point,
    required this.ticketsCount,
    required this.action,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width.w,
      height: 180.h,
      child: Column(
        spacing: 20,
        children: [
          SizedBox(
            width: width.w,
            height: 32.h,
            child: Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "보유 코인",
                  style: GogoTypography.body3Extrabold.copyWith(
                    color: GogoColors.gray300,
                  ),
                ),
                GogoIcons.stackedCoins(
                  color: GogoColors.white,
                ),
                Text(
                  '$point',
                  style: GogoTypography.body2Semibold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
                SizedBox(
                  width: 12.w,
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
                ),
              ],
            ),
          ),
          GogoTextField(
            controller: controller,
            hintText: '포인트를 입력해주세요',
            backgroundColor: GogoColors.gray700,
            keyboardType: TextInputType.number,
            endIcon: GogoIcons.pointCircle(),
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: GogoColors.gray400,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
              ),
              onPressed: () {},
              child: Text(
                action,
                style: GogoTypography.body3Semibold.copyWith(
                  color: GogoColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
