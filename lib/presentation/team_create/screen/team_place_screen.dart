import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/data/models/stage/handle_stage/stage_confirm_request.dart';
import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_bloc.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_event.dart';
import 'package:gogo_app/presentation/team_create/bloc/team_create_state.dart';
import 'package:gogo_app/router.dart';

import '../../../data/models/auth/student/student_response.dart';
import '../../../design_system/component/button/gogo_default_button.dart';
import '../../../design_system/component/top_bar/gogo_top_bar.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';
import '../../match_detail/widget/match_participant_widget.dart';

class TeamPlaceScreen extends StatefulWidget {
  const TeamPlaceScreen({
    super.key,
    required this.students,
    required this.game,
    required this.gameName,
    required this.gameId,
    required this.teamName,
  });

  final int gameId;
  final List<Student> students;
  final GameType game;
  final String gameName;
  final String teamName;

  @override
  State<TeamPlaceScreen> createState() => _TeamPlaceScreenState();
}

class _TeamPlaceScreenState extends State<TeamPlaceScreen> {
  final GlobalKey _fieldKey = GlobalKey();
  final List<ApplyParticipant> _applyParticipants = [];

  Widget _getGameCategoryText(GameType type) {
    switch (type) {
      case GameType.SOCCER:
        return GogoIcons.footballMap(width: 1200, height: 448);
      case GameType.BASKET_BALL:
        return GogoIcons.footballMap(width: 1200, height: 448);

      case GameType.BASE_BALL:
        return GogoIcons.footballMap(width: 1200, height: 448);

      case GameType.VOLLEY_BALL:
        return GogoIcons.footballMap(width: 1200, height: 448);

      case GameType.BADMINTON:
        return GogoIcons.footballMap(width: 1200, height: 448);
      default:
        return Container(
          width: 1200,
          height: 448,
          decoration: BoxDecoration(color: GogoColors.gray500),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _applyParticipants.addAll(
      widget.students.map((e) => ApplyParticipant(
            studentId: e.studentId,
            positionX: '0',
            positionY: '0',
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TeamCreateBloc(),
      child: BlocConsumer<TeamCreateBloc, TeamCreateState>(
          listener: (context, state) {
        if (state is TeamCreateSuccessState) {
          context.goNamed(PageRouter.stage);
        } else {
          if (state is TeamCreateFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        }
      }, builder: (context, state) {
        if (state is TeamCreateLoadingState) {
          return LoadingPage();
        } else {
          return Scaffold(
            body: SafeArea(
              child: Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: GogoTopBar(
                      title: '팀 생성',
                      onBackTap: () => context.pop(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.gameName,
                          style: GogoTypography.body2Extrabold
                              .copyWith(color: GogoColors.white),
                        ),
                        Row(
                          spacing: 12,
                          children: [
                            GogoIcons.shakeFinger(
                              width: 16,
                              height: 16,
                            ),
                            Text(
                              '인원을 배치 하세요',
                              style: GogoTypography.caption1Semibold
                                  .copyWith(color: Colors.white, fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    child: Stack(
                      key: _fieldKey,
                      children: [
                        _getGameCategoryText(widget.game),
                        ...List.generate(_applyParticipants.length, (index) {
                          final participant = _applyParticipants[index];
                          return Positioned(
                            left: double.parse(participant.positionX),
                            top: double.parse(participant.positionY),
                            child: Draggable(
                              feedback: Material(
                                color: Colors.transparent,
                                child: MatchParticipantItem(
                                  redOrBlue: null,
                                  name: widget.students[index].name,
                                ),
                              ),
                              childWhenDragging: Container(),
                              onDraggableCanceled: (velocity, offset) {
                                final RenderBox box = _fieldKey.currentContext!
                                    .findRenderObject() as RenderBox;
                                final localOffset = box.globalToLocal(offset);
                                final clampedDx =
                                    localOffset.dx.clamp(0.0, 1200.0 - 48);
                                final clampedDy =
                                    localOffset.dy.clamp(0.0, 448.0 - 48);
                                setState(() {
                                  _applyParticipants[index] = ApplyParticipant(
                                    studentId: participant.studentId,
                                    positionX: clampedDx.toString(),
                                    positionY: clampedDy.toString(),
                                  );
                                });
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: MatchParticipantItem(
                                  redOrBlue: null,
                                  name: widget.students[index].name,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 15, 95),
                    child: GogoDefaultButton(
                        onTap: () => context.read<TeamCreateBloc>().add(
                            PostTeamCreateEvent(widget.gameId,
                                teamApplyRequest: TeamApplyRequest(
                                    teamName: widget.teamName,
                                    participants: _applyParticipants))),
                        text: '확인'),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
