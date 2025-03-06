import 'package:flutter/material.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../widgets/tag_component.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TagComponent(
          tagState: TagState.isSelected,
            color: GogoColors.main500,
            icon: GogoIcons.volleyball(),
            text: "배구"),
      ),
    );
  }
}
