import 'package:flutter/material.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

class MatchParticipantWidget extends StatelessWidget {
  final double x;
  final double y;
  final bool redOrBlue;
  final String name;

  const MatchParticipantWidget(
      {super.key,
      required this.x,
      required this.y,
      required this.redOrBlue,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: redOrBlue ? null : x,
      right: redOrBlue ? x : null,
      top: y,
      child: Column(
        children: [
          GogoIcons.person(
              height: 20,
              width: 20,
              color: redOrBlue ? GogoColors.teamRed : GogoColors.teamBlue),
          Text(
            name,
            style: GogoTypography.body3Semibold.copyWith(
                color: redOrBlue ? GogoColors.teamRed : GogoColors.teamBlue),
          )
        ],
      ),
    );
  }
}
