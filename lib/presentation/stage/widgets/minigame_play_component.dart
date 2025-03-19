import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';

class MinigameSelectButton extends StatelessWidget {
  final String gameName;
  final Widget minigameImage;
  final VoidCallback onPressed;

  const MinigameSelectButton({
    required this.gameName,
    required this.minigameImage,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95,
      height: 95,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            GogoColors.gray600,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            minigameImage,
            SizedBox(
              height: 10,
            ),
            Text(
              gameName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GogoColors.gray400,
                fontFamily: "SUIT",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
