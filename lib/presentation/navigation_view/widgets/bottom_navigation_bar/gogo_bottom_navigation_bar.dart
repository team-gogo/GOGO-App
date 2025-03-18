import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class GogoBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const GogoBottomNavigationBar({super.key, required this.navigationShell});

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
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          print("현재 선택된 탭 index: $index");

          navigationShell.goBranch(index);
        },
        items: [
          _buildNavItem(
            icon: GogoIcons.home(
              color: navigationShell.currentIndex == 0
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "홈",
            isSelected: navigationShell.currentIndex == 0,
          ),
          _buildNavItem(
            icon: GogoIcons.stage(
              color: navigationShell.currentIndex == 1
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "스테이지",
            isSelected: navigationShell.currentIndex == 1,
          ),
          _buildNavItem(
            icon: GogoIcons.speakerPhone(
              color: navigationShell.currentIndex == 2
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "공지",
            isSelected: navigationShell.currentIndex == 2,
          ),
          _buildNavItem(
            icon: GogoIcons.person(
              color: navigationShell.currentIndex == 3
                  ? GogoColors.main600
                  : GogoColors.gray500,
            ),
            label: "프로필",
            isSelected: navigationShell.currentIndex == 3,
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
