import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellGame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/shellgame/shellgame_state.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_component.dart';

class ShellgameScreen extends StatelessWidget {

  final int point;
  final int ticketsCount;

  const ShellgameScreen({super.key, required this.point, required this.ticketsCount});

  Widget roundItem(int index, bool isSelected) {
    return Container(
      width: 68.6,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: isSelected ? Border(
          bottom: BorderSide(
            color: GogoColors.white,
            width: 1,
          ),
        ) : null,
      ),
      child: Text(
        '$index 라운드',
        style: GogoTypography.caption2Extrabold.copyWith(
          color: isSelected ? GogoColors.white : GogoColors.gray500,
        ),
      ),
    );
  }

  Widget selectNumberItem(int index, bool isSelected) {
    return Container(
      width: 105,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? null : Border.all(color: GogoColors.white),
        color: isSelected ? GogoColors.main600 : GogoColors.black,
      ),
      child: Text(
        '${index + 1}',
        style: GogoTypography.caption1Semibold.copyWith(
          color: GogoColors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShellGameBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GogoColors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Column(
                spacing: 24,
                children: [
                  GogoTopBar(
                    title: '야바위',
                    onBackTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  BlocBuilder<ShellGameBloc, ShellgameState>(
                    builder: (context, state) {
                      return Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 42,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) => roundItem(index + 1, index + 1 == state.round),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: GogoColors.gray700,
                    ),
                    child: const Stack(
                      children: [
                        //컵
                      ],
                    ),
                  ),
                  BlocBuilder<ShellGameBloc, ShellgameState>(
                    builder: (context, state) {
                      return Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              3,
                              (index) => GestureDetector(
                                onTap: () {
                                  context.read<ShellGameBloc>().add(PlaySelect(select: index));
                                },
                                child: selectNumberItem(index, index == state.playSelect),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  MinigameComponent(
                    point: point,
                    ticketsCount: ticketsCount,
                    action: '섞기',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}