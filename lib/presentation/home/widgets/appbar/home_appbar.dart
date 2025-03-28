import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/design_system/component/tag/gogo_date_tag_component.dart';

class HomeAppbar extends StatelessWidget {
  final int point;
  final DateTime selectedDate;
  final void Function(DateTime) setSelectedDate;

  const HomeAppbar({
    super.key,
    required this.point,
    required this.selectedDate,
    required this.setSelectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '포인트',
          style: GogoTypography.body2Semibold.copyWith(
            color: GogoColors.gray500,
          ),
        ),
        SizedBox(width: 12),
        Text(
          "${point}P",
          style: GogoTypography.caption1Extrabold
              .copyWith(color: GogoColors.white),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Stack(
            children: [
              // 날짜 태그 스크롤
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 7,
                  children: List.generate(
                    15,
                    (index) {
                      final DateTime dateTime =
                          DateTime.now().add(Duration(days: index - 7));
                      return GestureDetector(
                        onTap: () {
                          setSelectedDate(dateTime);
                        },
                        child: GogoDateTagComponent(
                          tagState: dateTime.day == selectedDate.day,
                          dateTime: dateTime,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: 0,
                bottom: 0,
                width: 40,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        GogoColors.black,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 40,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        GogoColors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
