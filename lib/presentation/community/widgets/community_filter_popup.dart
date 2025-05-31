import 'package:flutter/material.dart';
import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

Future<Map<String, dynamic>> filterDialog(BuildContext context,
    GameType? gameType, SortType? sortType, List<GameType> gameTypeList) async {
  final result = {'gameType': gameType, 'sortType': sortType};
  final dialogResult = await showDialog<Map<String, dynamic>>(
    barrierDismissible: false,
    context: context,
    builder: (_) => CommunityFilterPopup(
      gameType: gameType,
      sortType: sortType,
      gameTypeList: gameTypeList,
    ),
  );

  if (dialogResult != null) {
    result['gameType'] = dialogResult['gameType'];
    result['sortType'] = dialogResult['sortType'] ?? SortType.LAST;
  }

  return result;
}

class CommunityFilterPopup extends StatefulWidget {
  const CommunityFilterPopup(
      {super.key, this.gameType, this.sortType, required this.gameTypeList});

  final GameType? gameType;
  final SortType? sortType;
  final List<GameType> gameTypeList;

  @override
  State<CommunityFilterPopup> createState() => _CommunityFilterPopupState();
}

class _CommunityFilterPopupState extends State<CommunityFilterPopup> {
  late GameType? selectedGameType = widget.gameType;
  late SortType? selectedSortType = widget.sortType;

  static categoryTexts(GameType gameType) {
    switch (gameType) {
      case GameType.VOLLEY_BALL:
        return '배구';
      case GameType.BASKET_BALL:
        return '농구';
      case GameType.SOCCER:
        return '축구';
      case GameType.BASE_BALL:
        return '야구';
      case GameType.LOL:
        return 'LOL';
      case GameType.BADMINTON:
        return '배드민턴';
      default:
        return '기타';
    }
  }

  static categoryIcons(GameType gameType) {
    switch (gameType) {
      case GameType.VOLLEY_BALL:
        return GogoIcons.volleyball;
      case GameType.BASKET_BALL:
        return GogoIcons.basketball;
      case GameType.SOCCER:
        return GogoIcons.football;
      case GameType.BASE_BALL:
        return GogoIcons.baseball;
      case GameType.LOL:
        return GogoIcons.eSports;
      case GameType.BADMINTON:
        return GogoIcons.badminton;
      default:
        return GogoIcons.etc;
    }
  }

  static const sortTexts = ['최신 순', '오래된 순'];
  static const sortTypes = [SortType.LATEST, SortType.LAST];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GogoColors.gray700,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildCategorySelector(),
            const Divider(color: GogoColors.gray600, thickness: 1, height: 32),
            _buildSortSelector(),
            const SizedBox(height: 20),
            _buildNotice(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('필터',
            style:
                GogoTypography.body2Semibold.copyWith(color: GogoColors.white)),
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
    );
  }

  Widget _buildCategorySelector() {
    return Wrap(
      spacing: 12,
      runSpacing: 14,
      children: List.generate(widget.gameTypeList.length, (index) {
        final isSelected = selectedGameType == widget.gameTypeList[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedGameType = isSelected ? null : widget.gameTypeList[index];
            });
          },
          child: GogoTagComponent.small(
            tagState: isSelected,
            color: GogoColors.main500,
            text: categoryTexts(widget.gameTypeList[index]),
            icon: categoryIcons(widget.gameTypeList[index])(
              color: isSelected ? Colors.white : GogoColors.main500,
              width: 12.0,
              height: 12.0,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSortSelector() {
    return Wrap(
      spacing: 12,
      children: List.generate(sortTexts.length, (index) {
        final isSelected = selectedSortType == sortTypes[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedSortType =
                  isSelected ? widget.sortType : sortTypes[index];
            });
          },
          child: GogoTagComponent.small(
            tagState: isSelected,
            color: GogoColors.main500,
            text: sortTexts[index],
            icon: GogoIcons.alarm(
              color: isSelected ? Colors.white : GogoColors.main500,
              width: 12,
              height: 12,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNotice() {
    return Row(
      children: [
        GogoIcons.exclamationMarkCircle(
          width: 16,
          height: 16,
          color: GogoColors.gray500,
        ),
        const SizedBox(width: 8),
        Text(
          '한 개만 선택이 가능합니다',
          style: GogoTypography.caption1Semibold
              .copyWith(color: GogoColors.gray500),
        ),
      ],
    );
  }
}
