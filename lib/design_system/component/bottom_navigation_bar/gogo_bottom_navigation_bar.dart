import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/component/bottom_navigation_bar/bloc/gogo_bottom_navigation_bar_bloc.dart';
import 'package:gogo_app/design_system/component/bottom_navigation_bar/bloc/gogo_bottom_navigation_bar_event.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class GogoBottomNavigationBar extends StatelessWidget {
  const GogoBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GogoBottomNavigationBarBloc, int>(
        builder: (context, currentIndex) {
      return BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          context
              .read<GogoBottomNavigationBarBloc>()
              .add(GogoBottomNavigationBarEvent.values[index]);
        },
        selectedItemColor: GogoColors.main600,
        unselectedItemColor: GogoColors.gray500,
        selectedLabelStyle: GogoTypography.caption2Semibold,
        unselectedLabelStyle: GogoTypography.caption2Semibold,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: GogoIcons.home(
              color: currentIndex == 0 ? GogoColors.main600 : GogoColors.gray500,
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: GogoIcons.stage(
              color: currentIndex == 1? GogoColors.main600 : GogoColors.gray500,
            ),
            label: "스테이지",
          ),
          BottomNavigationBarItem(
            icon: GogoIcons.speakerPhone(
              color: currentIndex == 2 ? GogoColors.main600 : GogoColors.gray500,
            ),
            label: "공지",
          ),
          BottomNavigationBarItem(
            icon: GogoIcons.person(
              color: currentIndex == 3 ? GogoColors.main600 : GogoColors.gray500,
            ),
            label: "프로필",
          ),
        ],
      );
    });
  }
}
