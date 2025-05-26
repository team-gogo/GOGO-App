import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class GogoTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackTap;

  const GogoTopBar({
    super.key,
    required this.title,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GogoIcons.chevronLeft(
              onTap: onBackTap,
              color: GogoColors.white,
              width: 32,
              height: 32
            ),
            Text(
              title,
              style: GogoTypography.body2Semibold.copyWith(
                color: GogoColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
