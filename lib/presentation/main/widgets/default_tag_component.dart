import 'package:flutter/material.dart';
import 'package:gogo_app/core/design_system/theme/typography.dart';

abstract class DefaultTagComponent extends StatelessWidget {
  final Color color;
  final double borderWidth;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget icon;
  final String text;
  final TextStyle textStyle;

  const DefaultTagComponent({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.textStyle = GogoTypography.caption1Semibold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: borderWidth,
          ),
          borderRadius: borderRadius),
      child: Row(
        children: [
          icon,
          Text(
            text,
            style: textStyle.copyWith(color: color),
          )
        ],
      ),
    );
  }
}
