// gogo_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/router.dart';

class GogoDrawer extends StatelessWidget {
  const GogoDrawer({
    super.key,
  });

  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: GogoColors.black,
        width: 160,
        elevation: 0,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              spacing: 36,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GogoIcons.x(
                      onTap: () => context.pop(context),
                      color: GogoColors.white),
                ),
                _buildNavItem(
                  icon: GogoIcons.home(
                    height: 24.h,
                    width: 24.w,
                    color: currentIndex == 0
                        ? GogoColors.main600
                        : GogoColors.gray500,
                  ),
                  label: "홈",
                  isSelected: currentIndex == 0,
                  onTap: () {
                    PageRouter
                  },
                ),
                _buildNavItem(
                  icon: GogoIcons.stage(
                    height: 24.h,
                    width: 24.w,
                    color: currentIndex == 1
                        ? GogoColors.main600
                        : GogoColors.gray500,
                  ),
                  label: "스테이지",
                  isSelected: currentIndex == 1,
                  onTap: () {},
                ),
                _buildNavItem(
                  icon: GogoIcons.bell(
                    height: 24.h,
                    width: 24.w,
                    color: currentIndex == 2
                        ? GogoColors.main600
                        : GogoColors.gray500,
                  ),
                  label: "공지",
                  isSelected: currentIndex == 2,
                  onTap: () {},
                ),
                _buildNavItem(
                  icon: GogoIcons.person(
                    height: 24.h,
                    width: 24.w,
                    color: currentIndex == 3
                        ? GogoColors.main600
                        : GogoColors.gray500,
                  ),
                  label: "프로필",
                  isSelected: currentIndex == 3,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildNavItem({
    required Widget icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: 12,
        children: [
          icon,
          Text(label,
              style: GogoTypography.caption1Semibold.copyWith(
                  color: isSelected ? GogoColors.main600 : GogoColors.gray500)),
        ],
      ),
    );
  }
}
