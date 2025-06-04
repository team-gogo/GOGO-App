import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';

import '../../../design_system/theme/color.dart';

class UnDevelopedScreen extends StatelessWidget {
  const UnDevelopedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Text(
                  "현재\n개발 중입니다",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'GmarketSans',
                    fontSize: 48.sp,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = GogoColors.main600,
                  ),
                ),
                Transform.translate(
                  offset: Offset(5, -3),
                  child: Text(
                    "현재\n개발 중입니다",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 48.sp,
                      color: GogoColors.main600,
                    ),
                  ),
                ),
              ],
            ),
            GogoDefaultButton(
              onTap: () => context.pop(context),
              text: '뒤로가기',
              width: 150,
            )
          ],
        ),
      ),
    );
  }
}
