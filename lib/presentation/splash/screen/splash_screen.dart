import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/theme/color.dart';
import '../../../../design_system/theme/icon.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_bloc.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_event.dart';
import 'package:gogo_app/presentation/splash/bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SplashBloc()..add(LaunchSplashEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: GogoColors.black,
          body: Center(
            child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.86, end: 1.0),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
              child: GogoIcons.logo(width: double.infinity, height: 80),
            ),
          ),
        ),
      ),
    );
  }
}
