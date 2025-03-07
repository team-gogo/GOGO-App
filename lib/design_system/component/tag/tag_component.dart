import 'package:flutter/material.dart';
import '../../theme/typography.dart';

enum TagState { basic, isSelected }

class TagComponent extends StatelessWidget {
  final Color color;
  final double borderWidth;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final Widget? icon;
  final String text;
  final TextStyle textStyle;
  final TagState tagState;

  const TagComponent({
    super.key,
    required this.color,
    required this.text,
    this.icon,
    this.tagState = TagState.basic,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.spacing = 8,
    this.textStyle = GogoTypography.caption1Semibold,
  });

  const TagComponent.small({
    super.key,
    required this.color,
    required this.text,
    this.icon,
    this.tagState = TagState.basic,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.spacing = 4,
    this.textStyle = GogoTypography.caption3Semibold,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          border: tagState == TagState.isSelected
              ? null
              : Border.all(
                  color: color,
                  width: borderWidth,
                ),
          color: tagState == TagState.isSelected ? color : null,
          borderRadius: borderRadius),
      child: Row(
        spacing: spacing,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon == null ? SizedBox() : icon!,
          Text(
            text,
            style: textStyle.copyWith(
              color: tagState == TagState.isSelected ? null : color,
            ),
          )
        ],
      ),
    );
  }
}
