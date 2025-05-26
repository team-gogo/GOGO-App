import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../design_system/theme/color.dart';

class JoinStagePage extends StatelessWidget {
  const JoinStagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Text(
              "스테이지\n참여해주세요",
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
                "스테이지\n참여해주세요",
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
      ),
    );
  }
}
