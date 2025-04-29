import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/icon.dart';

import '../../theme/color.dart';
import '../../theme/typography.dart';

class GogoBorderlessTagComponent extends StatelessWidget {
  final Color color;

  final EdgeInsetsGeometry padding;
  final double spacing;
  final Widget icon;
  final String text;
  final TextStyle textStyle;

  const GogoBorderlessTagComponent({
    super.key,
    required this.color,
    required this.text,
    this.icon = const SizedBox(),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.spacing = 4,
    this.textStyle = GogoTypography.caption1Semibold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child:ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [color,color],
        ).createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Row(
          spacing: spacing,
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
      )
    );
  }
}