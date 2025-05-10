import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class ProfileCardComponent extends StatelessWidget {
  final String name;
  final String school;
  final String male;

  const ProfileCardComponent({
    super.key,
    required this.name,
    required this.school,
    required this.male,
  });

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
                    name,
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
                    school,
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
                    male,
                    style: mainStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
