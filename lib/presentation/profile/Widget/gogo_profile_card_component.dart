import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class GogoProfileCardComponent extends StatefulWidget {
  final String name;
  final String school;
  final String male;
  final bool selected; // 선택 되었을때 true, 선택 되지 않았을때 false
  final VoidCallback onTap;

  const GogoProfileCardComponent({
    super.key,
    required this.name,
    required this.school,
    required this.male,
    required this.selected,
    required this.onTap,
  });

  @override
  State<GogoProfileCardComponent> createState() =>
      _GogoProfileCardComponentState();
}

class _GogoProfileCardComponentState extends State<GogoProfileCardComponent> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle subjectStyle = GogoTypography.body3Semibold.copyWith(
      color: GogoColors.gray500,
    );

    final TextStyle mainStyle = GogoTypography.caption1Extrabold.copyWith(
      color: GogoColors.white,
    );
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: GogoColors.gray700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '이름',
                    style: subjectStyle,
                  ),
                  Text(
                    widget.name,
                    style: mainStyle,
                  ),
                ],
              ),
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '학교',
                    style: subjectStyle,
                  ),
                  Text(
                    widget.school,
                    style: mainStyle,
                  ),
                ],
              ),
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '성별',
                    style: subjectStyle,
                  ),
                  Text(
                    widget.male,
                    style: mainStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  selected = !selected;
                }),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    GogoIcons.gearWheel(
                      width: 24,
                      height: 24,
                      color: selected ? GogoColors.white : GogoColors.gray500,
                    ),
                    Text(
                      '설정',
                      style: selected
                          ? subjectStyle.copyWith(color: GogoColors.white)
                          : subjectStyle,
                    ),
                  ],
                ),
              ),
              if (selected)
                Container(
                  width: 147,
                  height: 286.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000),
                        blurRadius: 9,
                      ),
                    ],
                    color: GogoColors.gray700,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(),
                          alignment: Alignment.center,
                          child: Text(
                            '정보수정',
                            style: GogoTypography.body2Semibold.copyWith(
                              color: GogoColors.white,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(),
                          alignment: Alignment.center,
                          child: Text(
                            '회원 탈퇴',
                            style: GogoTypography.body2Semibold.copyWith(
                              color: GogoColors.error,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }
}
