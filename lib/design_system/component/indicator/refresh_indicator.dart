import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/theme/color.dart';

class GogoRefreshIndicator extends StatelessWidget {
  const GogoRefreshIndicator(
      {super.key, required this.onRefresh, required this.child});

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: onRefresh, child: child, backgroundColor: GogoColors.black, color: GogoColors.main600,);
  }
}
