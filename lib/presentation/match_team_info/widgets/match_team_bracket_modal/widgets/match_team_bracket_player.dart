import 'package:flutter/cupertino.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class MatchTeamBracketPlayer extends StatelessWidget {
  const MatchTeamBracketPlayer({super.key, required this.teamName, required this.isWin});

  final String? teamName;
  final bool isWin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWin ? GogoColors.main600 : GogoColors.gray600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 100,
        child: Text(
          teamName ?? "TBD",
          style: GogoTypography.caption3Extrabold.copyWith(
            color: GogoColors.white,
          ),
        ),
      ),
    );
  }
}
