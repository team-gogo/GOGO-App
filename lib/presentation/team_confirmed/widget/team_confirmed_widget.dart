import 'package:flutter/material.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_team_temp_response.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class TeamConfirmedWidget extends StatelessWidget {
  final TempTeam team;
  final bool isSelected;
  final VoidCallback onTap;

  const TeamConfirmedWidget({
    super.key,
    required this.team,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 58,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: GogoColors.gray700,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              team.teamName,
              style: GogoTypography.caption1Extrabold
                  .copyWith(color: GogoColors.white),
            ),
            Row(
              children: [
                Text(
                  '팀 자세히 보기',
                  style: GogoTypography.caption1Semibold
                      .copyWith(color: GogoColors.gray300),
                ),
                IconButton(
                  onPressed: onTap,
                  icon: isSelected
                      ? GogoIcons.checkboxFilled(
                          width: 24, height: 24, color: GogoColors.main500)
                      : GogoIcons.checkboxOutlined(
                          width: 24, height: 24, color: GogoColors.gray300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
