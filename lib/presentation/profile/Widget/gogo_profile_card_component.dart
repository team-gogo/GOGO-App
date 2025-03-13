import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class GogoProfileCardComponent extends StatelessWidget {
  final String name;
  final String school;
  final String male;

  const GogoProfileCardComponent({
    super.key,
    required this.name,
    required this.school,
    required this.male,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle subjectStyle = GogoTypography.body3Semibold.copyWith(
      fontSize: 16.sp,
      color: GogoColors.gray500,
    );

    final TextStyle mainStyle = GogoTypography.caption1Extrabold.copyWith(
      fontSize: 14.sp,
      color: GogoColors.white,
    );
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        color: GogoColors.gray700,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '이름',
                      style: subjectStyle,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      name,
                      style: mainStyle,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '학교',
                      style: subjectStyle,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      school,
                      style: mainStyle,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '성별',
                      style: subjectStyle,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      male,
                      style: mainStyle,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8.w,
              children: [
                GogoIcons.gearWheel(
                  width: 24.sp,
                  height: 24.sp,
                  color: GogoColors.gray500,
                ),
                Text(
                  '설정',
                  style: subjectStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
