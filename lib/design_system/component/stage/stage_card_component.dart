import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/component/tag/tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';

class StageCardComponent extends StatelessWidget {
  final String stageName;
  final Color color;
  final bool official;
  final bool recruiting;
  final bool manager;
  final bool broadcast;
  final VoidCallback onTap;
  final String buttonText;
  final Widget buttonIcon;

  const StageCardComponent({
    super.key,
    required this.stageName,
    required this.color,
    required this.official,
    required this.recruiting,
    required this.manager,
    required this.broadcast,
    required this.onTap,
    required this.buttonText,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      width: 343.w,
      child: Column(
        spacing: 28,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 12,
                children: [
                  official
                      ? TagComponent.small(
                          color: GogoColors.white,
                          text: '공식',
                          textStyle: GogoTypography.caption3Semibold,
                          icon: GogoIcons.trophy(
                            width: 12,
                            height: 12,
                            color: GogoColors.white,
                          ),
                        )
                      : SizedBox.shrink(),
                  TagComponent.small(
                    color: recruiting ? GogoColors.success : GogoColors.gray500,
                    text: recruiting ? '모집 중' : '모집 확정',
                    textStyle: GogoTypography.caption3Semibold,
                    icon: GogoIcons.stage(
                      width: 12,
                      height: 12,
                      color:
                          recruiting ? GogoColors.success : GogoColors.gray500,
                    ),
                  ),
                  manager
                      ? TagComponent.small(
                          color: GogoColors.main500,
                          text: '관리자',
                          textStyle: GogoTypography.caption3Semibold,
                          icon: GogoIcons.person(
                            width: 12,
                            height: 12,
                            color: GogoColors.main500,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              broadcast
                  ? TagComponent.small(
                      color: GogoColors.error,
                      text: '중계 설정',
                      textStyle: GogoTypography.caption3Semibold,
                      icon: GogoIcons.play(
                        width: 12,
                        height: 12,
                        color: GogoColors.error,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          Text(
            stageName,
            style:
                GogoTypography.body2Extrabold.copyWith(color: GogoColors.white),
          ),
          GogoIconButton(
            textStyle: GogoTypography.caption1Semibold,
            icon: buttonIcon,
            onTap: onTap,
            text: buttonText,
          ),
        ],
      ),
    );
  }
}
