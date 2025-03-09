import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/presentation/home/screen/home_screen.dart';
import 'package:gogo_app/presentation/notification/screen/notification_screen.dart';
import 'package:gogo_app/presentation/profile/screen/profile_screen.dart';
import 'package:gogo_app/presentation/stage/screen/stage_screen.dart';

import '../bloc/gogo_bottom_navigation_bar_bloc.dart';
import '../widgets/bottom_navigation_bar/gogo_bottom_navigation_bar.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GogoBottomNavigationBarBloc(),
      child: Scaffold(
        backgroundColor: GogoColors.black,
        body: BlocBuilder<GogoBottomNavigationBarBloc, int>(
          builder: (context, currentIndex) {
            switch (currentIndex) {
              case 0:
                return HomeScreen();
              case 1:
                return StageScreen();
              case 2:
                return NotificationScreen();
              case 3:
                return ProfileScreen();
              default:
                return HomeScreen();
            }
          },
        ),
        bottomNavigationBar: const GogoBottomNavigationBar(),
      ),
    );
  }
}
