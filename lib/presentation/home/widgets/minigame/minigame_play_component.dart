import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import '../../../../design_system/theme/color.dart';
import 'bloc/minigame_bloc.dart';
import 'bloc/minigame_event.dart';
import 'bloc/minigame_state.dart';

class MinigamePlayComponent extends StatelessWidget {
  const MinigamePlayComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MiniGameBloc(),
      child: BlocBuilder<MiniGameBloc, MiniGameState>(
        builder: (context, state) {
          String? selectedGame =
              state is MiniGameSelected ? state.selectedGame : null;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: MinigameSelectButton.gameIcons.keys.map((game) {
                bool isSelected = game == selectedGame;
                return MinigameSelectButton(
                  gameName: game,
                  minigameImage:
                      MinigameSelectButton.gameIcons[game]!(isSelected),
                  isSelected: isSelected,
                  onPressed: () {
                    context
                        .read<MiniGameBloc>()
                        .add(SelectGame(isSelected ? null : game));
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class MinigameSelectButton extends StatelessWidget {
  final String gameName;
  final Widget minigameImage;
  final bool isSelected;
  final VoidCallback onPressed;

  const MinigameSelectButton({
    required this.gameName,
    required this.minigameImage,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  static final Map<String, Widget Function(bool isSelected)> gameIcons = {
    '야바위': (isSelected) => GogoIcons.shellGame(
          color: isSelected ? GogoColors.main600 : GogoColors.gray400,
        ),
    '코인토스': (isSelected) => GogoIcons.pointCircle(
          color: isSelected ? GogoColors.main600 : GogoColors.gray400,
        ),
    '플린코': (isSelected) => GogoIcons.plinko(
          color: isSelected ? GogoColors.main600 : GogoColors.gray400,
        ),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104.sp,
      width: 104.sp,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isSelected ? GogoColors.gray500 : GogoColors.gray600,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            minigameImage,
            Text(
              gameName,
              style: GogoTypography.body3Semibold.copyWith(
                color: isSelected ? Colors.white : GogoColors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
