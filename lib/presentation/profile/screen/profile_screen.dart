import 'package:flutter/material.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            style: GogoTypography.title3Extrabold.copyWith(color: GogoColors.white),
            "Profile"
          ),
        )
    );
  }
}
