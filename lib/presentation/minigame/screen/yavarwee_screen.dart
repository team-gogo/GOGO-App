import 'package:flutter/material.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';

class YavarweeScreen extends StatelessWidget {

  final int point;
  final int ticketsCount;

  const YavarweeScreen({super.key, required this.point, required this.ticketsCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
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
