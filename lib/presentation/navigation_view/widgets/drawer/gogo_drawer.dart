// gogo_drawer.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/router.dart';

class GogoDrawer extends StatelessWidget {
  const GogoDrawer({
    super.key,
    required this.stageId,
  });

  final int stageId;

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
                        height: 24, width: 24, color: GogoColors.white),
                    label: "홈",
                    onTap: () {
                      context.pop(context);
                      context.pop(context);
                    }),
                _buildNavItem(
                  icon: GogoIcons.bell(
                      height: 24, width: 24, color: GogoColors.white),
                  label: "공지",
                  onTap: () =>
                      PageRouter.gogoPushNamed(PageRouter.alert, stageId),
                ),
                _buildNavItem(
                  icon: GogoIcons.person(
                      height: 24, width: 24, color: GogoColors.white),
                  label: "프로필",
                  onTap: () =>
                      PageRouter.gogoPushNamed(PageRouter.profile, stageId),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildNavItem({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(),
        child: Row(
          spacing: 12,
          children: [
            icon,
            Text(label,
                style: GogoTypography.caption1Semibold
                    .copyWith(color: GogoColors.white)),
          ],
        ),
      ),
    );
  }
}
