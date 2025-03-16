import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/widgets/communify_filter/bloc/community_filter_event.dart';

import 'bloc/community_filter_bloc.dart';
import 'bloc/community_filter_state.dart';

class CommunityFilterPopup extends StatelessWidget {
  const CommunityFilterPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categoryTexts = [
      '배구',
      '농구',
      '축구',
      '야구',
      'LoL',
      '배드민턴',
      '기타'
    ];
    final List<Widget Function({Color color, double height, double width})>
        categoryIcons = [
      GogoIcons.volleyball,
      GogoIcons.basketball,
      GogoIcons.football,
      GogoIcons.baseball,
      GogoIcons.eSports,
      GogoIcons.badminton,
      GogoIcons.etc
    ];

    final List<GameType> gameTypes = [
      GameType.VOLLEY_BALL,
      GameType.BASKET_BALL,
      GameType.SOCCER,
      GameType.BASE_BALL,
      GameType.LOL,
      GameType.BADMINTON,
      GameType.ETC,
    ];

    final List<String> sortTexts = ['최신 순', '오래된 순'];

    final List<SortType> sortType = [SortType.LASTEST, SortType.LAST];

    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => CommunitySportFilterBloc(),
            ),
            BlocProvider(
              create: (BuildContext context) => CommunitySortFilterBloc(),
            )
          ],
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: GogoColors.gray700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '필터',
                      style: GogoTypography.body2Semibold
                          .copyWith(color: GogoColors.white),
                    ),
                    GogoIcons.x(
                      width: 36,
                      height: 36,
                      color: GogoColors.white,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
                BlocBuilder<CommunitySportFilterBloc,
                    CommunitySportFilterState>(builder: (context, state) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 14,
                    children: List.generate(
                      categoryTexts.length,
                      (index) => GestureDetector(
                        onTap: () =>
                            context.read<CommunitySportFilterBloc>().add(
                                  SelectCommunitySportFilterEvent(
                                      gameType: gameTypes[index]),
                                ),
                        child: GogoTagComponent.small(
                          tagState:
                              state is SelectedCommunitySportFilterState &&
                                      state.gameType == gameTypes[index]
                                  ? TagState.isSelected
                                  : TagState.basic,
                          color: GogoColors.main500,
                          text: categoryTexts[index],
                          icon: categoryIcons[index](
                              color:
                                  state is SelectedCommunitySportFilterState &&
                                          state.gameType == gameTypes[index]
                                      ? Colors.white
                                      : GogoColors.main500,
                              height: 12,
                              width: 12),
                        ),
                      ),
                    ),
                  );
                }),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: GogoColors.gray600,
                ),
                BlocBuilder<CommunitySortFilterBloc, CommunitySortFilterState>(
                    builder: (context, state) {
                  return Wrap(
                    spacing: 12,
                    children: List.generate(
                      sortTexts.length,
                      (index) => GestureDetector(
                        onTap: () =>
                            context.read<CommunitySortFilterBloc>().add(
                                  SelectCommunitySortFilterEvent(
                                      sortType: sortType[index]),
                                ),
                        child: GogoTagComponent.small(
                          tagState: state is SelectedCommunitySortFilterState &&
                                  state.sortType == sortType[index]
                              ? TagState.isSelected
                              : TagState.basic,
                          color: GogoColors.main500,
                          text: sortTexts[index],
                          icon: GogoIcons.alarm(
                              color:
                                  state is SelectedCommunitySortFilterState &&
                                          state.sortType == sortType[index]
                                      ? Colors.white
                                      : GogoColors.main500,
                              height: 12,
                              width: 12),
                        ),
                      ),
                    ),
                  );
                }),
                Row(
                  children: [
                    GogoIcons.exclamationMarkCircle(
                        width: 16, height: 16, color: GogoColors.gray500),
                    const SizedBox(width: 8),
                    Text(
                      '한 개만 선택이 가능합니다',
                      style: GogoTypography.caption1Semibold
                          .copyWith(color: GogoColors.gray500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
