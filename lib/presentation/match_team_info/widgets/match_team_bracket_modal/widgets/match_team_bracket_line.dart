import 'package:flutter/cupertino.dart';

import '../../../../../design_system/theme/color.dart';

class MatchTeamBracketLine extends StatelessWidget {
  const MatchTeamBracketLine(
      {super.key, required this.isLeft, required this.height});

  final bool isLeft;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isLeft
            ? BorderRadius.horizontal(right: Radius.circular(12))
            : BorderRadius.horizontal(left: Radius.circular(12)),
        border: Border(
          top: BorderSide(color: GogoColors.gray600, width: 4),
          right: isLeft
              ? BorderSide(color: GogoColors.gray600, width: 4)
              : BorderSide.none,
          left: isLeft
              ? BorderSide.none
              : BorderSide(color: GogoColors.gray600, width: 4),
          bottom: BorderSide(color: GogoColors.gray600, width: 4),
        ),
      ),
      width: 120,
      height: height,
    );
  }
}
