import 'package:flutter/material.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

enum TeamColor { red, blue }

class MatchParticipantWidget extends StatelessWidget {
  final double x;
  final double y;
  final TeamColor? redOrBlue;
  final String name;

  const MatchParticipantWidget({
    super.key,
    required this.x,
    required this.y,
    required this.name,
    this.redOrBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: redOrBlue == TeamColor.red ? null : x,
      right: redOrBlue == TeamColor.red ? x : null,
      top: y,
      child: MatchParticipantItem(
        redOrBlue: redOrBlue,
        name: name,
      ),
    );
  }
}

class MatchParticipantItem extends StatelessWidget {
  const MatchParticipantItem({super.key, this.redOrBlue, required this.name});

  final TeamColor? redOrBlue;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GogoIcons.person(
            height: 20,
            width: 20,
            color: redOrBlue == null
                ? GogoColors.white
                : redOrBlue == TeamColor.red
                    ? GogoColors.teamRed
                    : GogoColors.teamBlue),
        Text(
          name,
          style: GogoTypography.body3Semibold.copyWith(
              color: redOrBlue == null
                  ? GogoColors.white
                  : redOrBlue == TeamColor.red
                      ? GogoColors.teamRed
                      : GogoColors.teamBlue),
        )
      ],
    );
  }
}
