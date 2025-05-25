import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/presentation/loading/widgets/loading_indicator.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_info_modal/bloc/match_team_info_modal_bloc.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_info_modal/bloc/match_team_info_modal_event.dart';
import 'package:gogo_app/presentation/match_team_info/widgets/match_team_info_modal/bloc/match_team_info_modal_state.dart';
import '../../../../../design_system/theme/typography.dart';
import '../../../../match_detail/widget/match_participant_widget.dart';

class MatchTeamInfoModal extends StatelessWidget {
  MatchTeamInfoModal(
      {super.key,
      required this.teamId,
      required this.winCount,
      required this.game});

  final int winCount;
  final int teamId;
  final GameType game;

  final ScrollController _scrollController = ScrollController();

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

  static Widget _halfImage(GameType category, {required bool isLeft}) {
    final image = switch (category) {
      GameType.SOCCER => isLeft
          ? GogoIcons.footballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.footballMap(),
            ),
      GameType.BASKET_BALL => isLeft
          ? GogoIcons.basketballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.basketballMap(),
            ),
      GameType.BASE_BALL => isLeft
          ? GogoIcons.baseballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.baseballMap(),
            ),
      GameType.VOLLEY_BALL => isLeft
          ? GogoIcons.volleyballMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.volleyballMap(),
            ),
      GameType.BADMINTON => isLeft
          ? GogoIcons.badmintonMap()
          : Transform.flip(
              flipX: true,
              child: GogoIcons.badmintonMap(),
            ),
      GameType.LOL => Container(color: GogoColors.gray600), //TODO: 스테이지 삽입 요망
      GameType.ETC => Container(color: GogoColors.gray600), //TODO: 스테이지 삽입 요망
    };
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          MatchTeamInfoModalBloc()..add(GetMatchTeamInfo(teamId: teamId)),
      child: Dialog(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: GogoColors.gray700,
        child: BlocBuilder<MatchTeamInfoModalBloc, MatchTeamInfoModalState>(
            builder: (context, state) {
          if (state is LoadedMatchTeamInfo) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                spacing: 18,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.teamInfoResponse.teamName,
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: GogoColors.white),
                      ),
                      GogoIcons.x(
                          color: GogoColors.white,
                          onTap: () => context.pop(context)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Row(
                            spacing: 8,
                            children: [
                              GogoIcons.trophy(color: GogoColors.white),
                              Text(
                                '$winCount승',
                                style: GogoTypography.caption2Semibold
                                    .copyWith(color: GogoColors.white),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Row(
                            spacing: 8,
                            children: [
                              GogoIcons.person(color: GogoColors.main300),
                              Text(
                                '${state.teamInfoResponse.participantCount}명',
                                style: GogoTypography.caption2Semibold
                                    .copyWith(color: GogoColors.main300),
                              )
                            ],
                          )),
                      Expanded(
                        flex: 2,
                        child: Row(
                          spacing: 8,
                          children: [
                            categoryIcons(game)(
                                color: GogoColors.main500,
                                width: 20.0,
                                height: 20.0),
                            Text(categoryTexts(game),
                                style: GogoTypography.caption2Semibold
                                    .copyWith(color: GogoColors.main500)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox.shrink(),
                      ),
                    ],
                  ),
                  RawScrollbar(
                    thickness: 3,
                    thumbColor: GogoColors.gray400,
                    trackColor: GogoColors.gray600,
                    trackVisibility: true,
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Stack(
                        children: [
                          _halfImage(
                            game,
                            isLeft: true,
                          ),
                          ...state.teamInfoResponse.participant.map(
                            (e) => MatchParticipantWidget(
                                x: double.tryParse(e.positionX) ?? 0 * 660,
                                y: double.tryParse(e.positionY) ?? 0 * 448,
                                redOrBlue: false,
                                name: e.name),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is LoadingMatchTeamInfo ||
              state is InitMatchTeamInfo) {
            return Container(
                height: 400,
                width: double.infinity,
                alignment: Alignment.center,
                child: LoadingIndicator());
          } else {
            return Text('Error loading team info',
                style: GogoTypography.caption3Semibold
                    .copyWith(color: GogoColors.error));
          }
        }),
      ),
    );
  }
}
