import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_state.dart';

import '../../../design_system/theme/color.dart';

class MinigamePlayComponent extends StatelessWidget {
  final double width;

  const MinigamePlayComponent({
    super.key,
    this.width = 343,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MiniGameBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width.w,
            height: 24.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    GogoIcons.arcade(color: Colors.white),
                    Text(
                      "미니게임",
                      style: GogoTypography.body2Extrabold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8.w,
                  children: [
                    Text(
                      "더보기",
                      style: GogoTypography.caption1Semibold.copyWith(
                        color: GogoColors.gray500,
                      ),
                    ),
                    GogoIcons.chevronRight(color: GogoColors.gray500),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: width.w,
            height: 183.h,
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: GogoColors.gray700,
            ),
            child: BlocBuilder<MiniGameBloc, MiniGameState>(
              builder: (context, state) {
                String? selectedGame =
                    state is MiniGameSelected ? state.selectedGame : null;
                return Column(
                  children: [
                    Container(
                      width: 309.w,
                      height: 95.h,
                      child: Row(
                        spacing: 8.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...gameIcons.keys.map((game) {
                            bool isSelected = game == selectedGame;
                            return MinigameSelectButton(
                              gameName: game,
                              minigameImage: gameIcons[game]!(isSelected),
                              isSelected: isSelected,
                              onPressed: () {
                                if (selectedGame == game) {
                                  context
                                      .read<MiniGameBloc>()
                                      .add(SelectGame(null));
                                } else {
                                  context
                                      .read<MiniGameBloc>()
                                      .add(SelectGame(game));
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: 309.w,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 16.w),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            selectedGame != null
                                ? GogoColors.main600
                                : GogoColors.gray400,
                          ),
                        ),
                        onPressed: selectedGame != null ? () {} : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "게임 하기",
                              style: GogoTypography.caption1Semibold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            GogoIcons.chevronRight(color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final Map<String, Widget Function(bool isSelected)> gameIcons = {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      height: 95.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            isSelected ? GogoColors.gray500 : GogoColors.gray600,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            minigameImage,
            SizedBox(height: 10.h),
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
