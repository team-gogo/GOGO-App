import 'package:flutter/material.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';

class AppleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.black12),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        elevation: 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GogoIcons.appleLogo(),
          SizedBox(width: 12),
          Text(
            "Apple 계정으로 로그인",
            style: GogoTypography.caption1Semibold
                .copyWith(color: GogoColors.black),
          ),
        ],
      ),
    );
  }
}
