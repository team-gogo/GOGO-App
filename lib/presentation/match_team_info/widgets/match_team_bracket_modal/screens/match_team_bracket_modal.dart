import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_bracket_modal/widgets/match_team_bracket.dart';
import '../../../../../design_system/theme/color.dart';
import '../../../../../design_system/theme/icon.dart';
import '../../../../../design_system/theme/typography.dart';

class MatchTeamBracketModal extends StatelessWidget {
  MatchTeamBracketModal({super.key, required this.gameId});

  final int gameId;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: GogoColors.gray700,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 18,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '대진표',
                  style: GogoTypography.body2Extrabold
                      .copyWith(color: GogoColors.white),
                ),
                GogoIcons.x(
                    color: GogoColors.white, onTap: () => context.pop(context)),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(color: GogoColors.gray600),
            ),
            RawScrollbar(
                thickness: 3,
                thumbColor: GogoColors.gray400,
                trackColor: GogoColors.gray600,
                trackVisibility: true,
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: MatchTeamBracket(gameId: gameId,))),
          ],
        ),
      ),
    );
  }
}
