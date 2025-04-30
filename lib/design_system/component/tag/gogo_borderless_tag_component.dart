import 'package:flutter/material.dart';
import '../../theme/typography.dart';

class GogoBorderlessTagComponent extends StatelessWidget {
  final Color color;

  final double spacing;
  final Widget icon;
  final String text;
  final TextStyle textStyle;

  const GogoBorderlessTagComponent({
    super.key,
    required this.color,
    required this.text,
    this.icon = const SizedBox(),
    this.spacing = 4,
    this.textStyle = GogoTypography.caption1Semibold,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [color,color],
        ).createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Row(
          children: [
            icon,
            SizedBox(width: spacing),
            Text(
              text,
              style: textStyle.copyWith(
                fontSize: 12,
                color: null
              ),
            ),
          ],
        ),
    );
  }
}