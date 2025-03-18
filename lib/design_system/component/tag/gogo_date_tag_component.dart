import 'package:flutter/cupertino.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:intl/intl.dart';

import '../../theme/color.dart';
import '../../theme/typography.dart';

class GogoDateTagComponent extends StatelessWidget {
  final Color color;
  final double borderWidth;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final DateTime dateTime;
  final TextStyle textStyle;
  final TagState tagState;

  const GogoDateTagComponent({
    super.key,
    required this.dateTime,
    this.color = GogoColors.main600,
    this.tagState = TagState.basic,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.spacing = 8,
    this.textStyle = GogoTypography.caption1Semibold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: tagState == TagState.isSelected
            ? null
            : Border.all(
                color: GogoColors.gray500,
                width: borderWidth,
              ),
        color: tagState == TagState.isSelected ? color : null,
      ),
      child: Text(
        '${DateFormat('MM').format(dateTime)} - ${DateFormat.d().format(dateTime)}',
        style: GogoTypography.caption3Semibold.copyWith(
          color: tagState == TagState.isSelected
              ? GogoColors.white
              : GogoColors.gray500,
        ),
      ),
    );
  }
}
