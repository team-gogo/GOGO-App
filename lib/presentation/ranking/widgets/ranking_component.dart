import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class RankingComponent extends StatelessWidget {
  final String points;
  final String name;
  final List<Color> colors;
  final double circleSize;
  final double iconSize;

  const RankingComponent({
    super.key,
    required this.points,
    required this.name,
    required this.colors,
    required this.circleSize,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
              stops: [0.0, 0.365, 1.0],
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: Text(
            points,
            style: GogoTypography.caption2Semibold,
          ),
        ),
        SizedBox(height: 4),
        Text(name,
            style: GogoTypography.body3Extrabold.copyWith(
              color: GogoColors.white,
            )),
        SizedBox(height: 16),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
              stops: [0.0, 0.365, 1.0],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.military_tech,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
