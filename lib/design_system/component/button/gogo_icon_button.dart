import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';

class GogoIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Border? border;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color textColor;
  final Widget icon;
  final double spacing;

  const GogoIconButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
    ),
    this.color = GogoColors.main600,
    this.border,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    this.textStyle = GogoTypography.body3Semibold,
    this.textColor = GogoColors.white,
    required this.icon,
    this.spacing = 8,
  });

  GogoIconButton.outlined({
    super.key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
    ),
    this.color = Colors.transparent,
    this.border,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    this.textStyle = GogoTypography.body3Semibold,
    this.textColor = GogoColors.main500,
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
            color: color, borderRadius: borderRadius, border: border),
        child: Row(
          spacing: spacing,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
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
