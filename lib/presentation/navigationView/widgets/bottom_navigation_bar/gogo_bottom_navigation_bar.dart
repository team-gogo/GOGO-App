import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import '../../bloc/gogo_bottom_navigation_bar_bloc.dart';
import '../../bloc/gogo_bottom_navigation_bar_event.dart';

class GogoBottomNavigationBar extends StatelessWidget {
  const GogoBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Divider(
        height: 1,
        thickness: 1,
        color: GogoColors.gray500,
      ),
      BlocBuilder<GogoBottomNavigationBarBloc, int>(
        builder: (context, currentIndex) {
          return BottomNavigationBar(
            backgroundColor: GogoColors.black,
            elevation: 0,
            currentIndex: currentIndex,
            onTap: (index) {
              context
                  .read<GogoBottomNavigationBarBloc>()
                  .add(GogoBottomNavigationBarEvent.values[index]);
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
          );
        },
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
