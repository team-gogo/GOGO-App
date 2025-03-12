import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/component/tag/tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';

class StageCardComponent extends StatelessWidget {
  final String stageName;
  final TextStyle stageTextStyle;
  final Color color;
  final TextStyle tagTextStyle;
  final bool official; // 공식: true, 비공식: false
  final bool recruiting; // 모집 중: true, 모집 확정: false
  final bool manager; // 관리자 태그가 보임: true, 안보임: false
  final bool broadcast; // 중계 설정 태그가 보임: true, 안보임: false
  final VoidCallback onTap;
  final String buttonText;
  final double buttonWidth;
  final Widget buttonIcon;

  const StageCardComponent({
    super.key,
    required this.stageName,
    this.stageTextStyle = GogoTypography.body1Extrabold,
    required this.color,
    this.tagTextStyle = GogoTypography.caption3Semibold,
    required this.official,
    required this.recruiting,
    required this.manager,
    required this.broadcast,
    required this.onTap,
    required this.buttonText,
    this.buttonWidth = double.infinity,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          color: color,
        ),
        height: 183.h,
        width: 320.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  spacing: 8.w,
                  children: [
                    official
                        ? TagComponent.small(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.h)),
                            spacing: 4.w,
                            color: GogoColors.white,
                            text: '공식',
                            textStyle: tagTextStyle,
                            icon: GogoIcons.trophy(
                              width: 12.sp,
                              height: 12.sp,
                              color: GogoColors.white,
                            ),
                          )
                        : SizedBox.shrink(),
                    TagComponent.small(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      borderRadius: BorderRadius.all(Radius.circular(8.h)),
                      spacing: 4.w,
                      color:
                          recruiting ? GogoColors.success : GogoColors.gray500,
                      text: recruiting ? '모집 중' : '모집 확정',
                      textStyle: tagTextStyle,
                      icon: GogoIcons.stage(
                        width: 12.sp,
                        height: 12.sp,
                        color: recruiting
                            ? GogoColors.success
                            : GogoColors.gray500,
                      ),
                    ),
                    manager
                        ? TagComponent.small(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.h)),
                            spacing: 4.w,
                            color: GogoColors.main500,
                            text: '관리자',
                            textStyle: tagTextStyle,
                            icon: GogoIcons.person(
                              width: 12.sp,
                              height: 12.sp,
                              color: GogoColors.main500,
                            ),
                          )
                        : SizedBox.shrink(),
                    SizedBox(width: 16.w),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: broadcast
                    ? TagComponent.small(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        borderRadius: BorderRadius.all(Radius.circular(8.h)),
                        spacing: 4.w,
                        color: GogoColors.error,
                        text: '중계 설정',
                        textStyle: tagTextStyle,
                        icon: GogoIcons.play(
                          width: 12.sp,
                          height: 12.sp,
                          color: GogoColors.error,
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 28.h),
                  child: Text(
                    stageName,
                    style: stageTextStyle.copyWith(color: GogoColors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 45.h,
                  child: GogoIconButton(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    icon: buttonIcon,
                    spacing: 8.w,
                    onTap: onTap,
                    text: buttonText,
                    width: buttonWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
