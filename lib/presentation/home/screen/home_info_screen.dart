import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';

class HomeInfoScreen extends StatelessWidget {
  const HomeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GogoTopBar(
            title: '매치 목록',
            onBackTap: () => context.pop(context),
          ),

        ],
      ),
    );
  }
}
