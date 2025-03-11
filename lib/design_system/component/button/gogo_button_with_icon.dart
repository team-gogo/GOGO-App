import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';

class GogoButtonWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color textColor;
  final Widget icon;
  final double spacing;

  const GogoButtonWithIcon({
    super.key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
    ),
    this.color = GogoColors.main600,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    this.textStyle = GogoTypography.body3Semibold,
    this.textColor = GogoColors.white,
    required this.icon,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: spacing,
            ),
            Text(
              text,
              style: textStyle.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
