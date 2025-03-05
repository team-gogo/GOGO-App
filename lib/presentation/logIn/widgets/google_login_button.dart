import 'package:flutter/material.dart';
import '../../../../core/design_system/theme/icon.dart';
import '../../../../core/design_system/theme/typography.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({super.key, required this.onPressed});

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
          GogoIcons.googleLogo(),
          SizedBox(width: 12),
          Text("Google 계정으로 로그인", style: GogoTypography.caption1Semibold),
        ],
      ),
    );
  }
}
