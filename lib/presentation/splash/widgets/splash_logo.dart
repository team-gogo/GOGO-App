import 'package:flutter/material.dart';
import 'package:gogo_app/core/design_system/theme/icon.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'gogo_splash_icon',
        child: GogoIcons.logo(
          width: 210,
          height: 72
        )
    );
  }
}