import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/auth/student/student_response.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/team_create/screen/team_place_screen.dart';
import '../../stage_create/widgets/stage_student_manage_popup.dart';

import '../../../design_system/component/button/gogo_default_button.dart';

class TeamCreateScreen extends StatefulWidget {
  const TeamCreateScreen(
      {super.key,
      required this.gameId,
      required this.minimumTeamSize,
      required this.maximumTeamSize,
      required this.game,
      required this.gameName});

  final String gameName;
  final int gameId;
  final int minimumTeamSize;
  final int maximumTeamSize;
  final GameType game;

  @override
  State<TeamCreateScreen> createState() => _TeamCreateScreen();
}

class _TeamCreateScreen extends State<TeamCreateScreen> {
  final TextEditingController _teamNameController = TextEditingController();
  List<Student> _students = [];

  Widget _editItem(String text, Widget child) => Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GogoTypography.body2Extrabold.copyWith(
              color: GogoColors.white,
            ),
          ),
          child
        ],
      );

  @override
  void initState() {
    _teamNameController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GogoColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 17, 16, 0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 36,
                children: [
                  GogoTopBar(
                    title: '팀 생성',
                    onBackTap: () => context.pop(context),
                  ),
                  Text(
                    widget.gameName,
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _editItem(
                              '팀 이름',
                              GogoTextField(
                                controller: _teamNameController,
                                hintText: '팀 이름을 입력해주세요',
                                maxLength: 6,
                              ),
                            ),
                            Text(
                              '${_teamNameController.text.length}/6',
                              style: GogoTypography.body3Semibold.copyWith(
                                color: GogoColors.gray500,
                              ),
                            ),
                          ],
                        ),
                        _editItem(
                          '인원',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final result = await stageStudentManagePopup(
                                      context,
                                      _students,
                                      widget.minimumTeamSize,
                                      widget.maximumTeamSize);
                                  setState(() {
                                    _students = result;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: GogoColors.gray700,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: _students.isNotEmpty
                                      ? Wrap(
                                          children: List.generate(
                                            _students.length,
                                            (index) => Text(
                                              "${_students[index].grade}${_students[index].classNumber}${_students[index].studentNumber.toString().padLeft(2, '0')} ${_students[index].name} ${index + 1 == _students.length ? '' : ', '}",
                                              style: GogoTypography
                                                  .body3Semibold
                                                  .copyWith(
                                                      color: GogoColors.white),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          '학생을 입력해주세요',
                                          style: GogoTypography.body3Semibold
                                              .copyWith(
                                                  color: GogoColors.gray400),
                                        ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                spacing: 12,
                                children: [
                                  GogoIcons.questionMarkCircle(
                                      color: GogoColors.gray500),
                                  Text(
                                    '최소 인원 : ${widget.minimumTeamSize}명   최대 인원 : ${widget.maximumTeamSize}명',
                                    style:
                                        GogoTypography.body3Semibold.copyWith(
                                      color: GogoColors.gray500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              GogoDefaultButton(
                onTap: (_students.length < widget.minimumTeamSize ||
                            _students.length > widget.maximumTeamSize) ||
                        _teamNameController.text == ""
                    ? () {}
                    : () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (builder) => TeamPlaceScreen(
                                teamName: _teamNameController.text,
                                gameId: widget.gameId,
                                students: _students,
                                game: widget.game,
                                gameName: widget.gameName))),
                text: '확인',
                color: (_students.length < widget.minimumTeamSize ||
                            _students.length > widget.maximumTeamSize) ||
                        _teamNameController.text == ""
                    ? GogoColors.gray400
                    : GogoColors.main600,
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
