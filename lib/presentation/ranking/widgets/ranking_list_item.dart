import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class RankingListItem extends StatelessWidget {
  final int index;
  final String name;
  final int point;

  const RankingListItem(
      {super.key,
      required this.index,
      required this.name,
      required this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: GogoColors.gray700,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 24,
            children: [
              Text(
                "${index + 4}등",
                style: GogoTypography.caption1Extrabold.copyWith(
                  color: GogoColors.white,
                ),
              ),
              Text(
                name,
                style: GogoTypography.caption1Semibold.copyWith(
                  color: GogoColors.gray300,
                ),
              ),
            ],
          ),
          Text(
            "${point.toInt()}P",
            style: GogoTypography.caption1Extrabold.copyWith(
              color: GogoColors.main400,
            ),
          ),
        ],
      ),
    );
  }
}
