// gogo_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/router.dart';

class GogoBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;

  const GogoBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Divider(
        thickness: 0.5,
        height: 0,
        color: GogoColors.gray500,
      ),
      BottomNavigationBar(
        backgroundColor: GogoColors.black,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          onTap(index);
        },
        items: [
          _buildNavItem(
            icon: GogoIcons.home(
              color: currentIndex == 0
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "홈",
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            icon: GogoIcons.stage(
              color: currentIndex == 1
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "스테이지",
            isSelected: currentIndex == 1,
          ),
          _buildNavItem(
            icon: GogoIcons.speakerPhone(
              color: currentIndex == 2
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "공지",
            isSelected: currentIndex == 2,
          ),
          _buildNavItem(
            icon: GogoIcons.person(
              color: currentIndex == 3
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "프로필",
            isSelected: currentIndex == 3,
          ),
        ],
      )
    ]);
  }

  BottomNavigationBarItem _buildNavItem({
    required Widget icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: GogoColors.black,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: GogoTypography.caption2Semibold.fontSize,
              fontWeight: GogoTypography.caption2Semibold.fontWeight,
              color: isSelected ? GogoColors.main600 : GogoColors.gray500,
            ),
          ),
        ],
      ),
      label: "",
    );
  }
}
