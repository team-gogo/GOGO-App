import 'package:flutter/material.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class CommunityFilterPopup extends StatefulWidget {
  const CommunityFilterPopup({
    super.key,
    required this.gameType,
    required this.sortType,
  });

  final GameType? gameType;
  final SortType? sortType;

  @override
  _CommunityFilterPopupState createState() => _CommunityFilterPopupState();
}

class _CommunityFilterPopupState extends State<CommunityFilterPopup> {
  GameType? selectedGameType;
  SortType? selectedSortType;

  @override
  void initState() {
    super.initState();
    selectedGameType = widget.gameType;
    selectedSortType = widget.sortType;
  }

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
    final List<SortType> sortTypes = [SortType.LASTEST, SortType.LAST];

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GogoColors.gray700,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
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
                  onTap: () => Navigator.pop(context, {
                    'gameType': selectedGameType,
                    'sortType': selectedSortType,
                  }),
                ),
              ],
            ),
            Wrap(
              spacing: 12,
              runSpacing: 14,
              children: List.generate(
                categoryTexts.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGameType = selectedGameType == gameTypes[index]
                          ? null
                          : gameTypes[index];
                    });
                  },
                  child: GogoTagComponent.small(
                    tagState: selectedGameType == gameTypes[index],
                    color: GogoColors.main500,
                    text: categoryTexts[index],
                    icon: categoryIcons[index](
                        color: selectedGameType == gameTypes[index]
                            ? Colors.white
                            : GogoColors.main500,
                        height: 12,
                        width: 12),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: GogoColors.gray600,
            ),
            Wrap(
              spacing: 12,
              children: List.generate(
                sortTexts.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSortType = selectedSortType == sortTypes[index]
                          ? null
                          : sortTypes[index];
                    });
                  },
                  child: GogoTagComponent.small(
                    tagState: selectedSortType == sortTypes[index],
                    color: GogoColors.main500,
                    text: sortTexts[index],
                    icon: GogoIcons.alarm(
                        color: selectedSortType == sortTypes[index]
                            ? Colors.white
                            : GogoColors.main500,
                        height: 12,
                        width: 12),
                  ),
                ),
              ),
            ),
            Row(
              spacing: 8,
              children: [
                GogoIcons.exclamationMarkCircle(
                    width: 16, height: 16, color: GogoColors.gray500),
                Text(
                  '한 개만 선택이 가능합니다',
                  style: GogoTypography.caption1Semibold
                      .copyWith(color: GogoColors.gray500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
