import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';

class YavarweeScreen extends StatelessWidget {

  final int point;
  final int ticketsCount;
  final int round = 1;

  const YavarweeScreen({super.key, required this.point, required this.ticketsCount});

  Widget roundItem(int index,bool isSelected) {
    return Container(
      width: 68.6,
      height: 42,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: GogoColors.white,
            width: isSelected ? 1 : 0,
          ),
        ),
      ),
      child: Text('$index 라운드'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GogoTopBar(
              title: '야바위',
              onBackTap: () {
                Navigator.pop(context);
              },
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return roundItem(index, index == round);
              }
            ),
            MinigameComponent(
              point: point,
              ticketsCount: ticketsCount,
              action: '섞기',
              controller: TextEditingController(),
            )
          ],
        ),
      ),
    );
  }
}
