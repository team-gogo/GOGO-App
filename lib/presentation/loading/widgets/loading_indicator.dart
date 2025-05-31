import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../design_system/theme/color.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1250),
      vsync: this,
    )..repeat();

    _dotsAnimation = IntTween(begin: 0, end: 3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _dotsAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              Text(
                "로딩 중${'.' * _dotsAnimation.value}",
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
                  "로딩 중${'.' * _dotsAnimation.value}",
                  style: TextStyle(
                    fontFamily: 'GmarketSans',
                    fontSize: 48.sp,
                    color: GogoColors.main600,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
