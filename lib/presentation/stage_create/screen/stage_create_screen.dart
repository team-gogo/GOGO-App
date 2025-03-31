import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/common/match_dto.dart';
import 'package:gogo_app/data/models/stage/create_stage/game.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';

import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';
import '../widgets/stage_base_component.dart';

class StageCreateScreen extends StatefulWidget {
  StageCreateScreen({super.key});

  @override
  State<StageCreateScreen> createState() => _StageCreateScreenState();
}

class _StageCreateScreenState extends State<StageCreateScreen> {
  bool isDropdownOpen = false;
  final GlobalKey dropdownKey = GlobalKey();
  Offset? position;

  final TextEditingController _stageNameController = TextEditingController();

  final TextEditingController _stageBettingPointController =
      TextEditingController();

  GameType? _matchGameType;

  final TextEditingController _matchNameController = TextEditingController();

  GameSystem? _matchGameSystem;

  final TextEditingController _matchMinimumNumberPlayersController =
      TextEditingController();

  final TextEditingController _matchMaximumNumberPlayersController =
      TextEditingController();

  final TextEditingController _ruleMinimumNumberBettingPointController =
      TextEditingController();

  final TextEditingController _ruleMaximumNumberBettingPointController =
      TextEditingController();

  bool selectCoinToss = false;

  final TextEditingController _coinTossRuleMinimumNumberBettingPointController =
      TextEditingController();

  final TextEditingController _coinTossRuleMaximumNumberBettingPointController =
      TextEditingController();

  final TextEditingController _coinTossBettingTicketController =
      TextEditingController();

  final TextEditingController _admissionNumberController =
      TextEditingController();

  final List<int> _studentsManage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                children: [
                  GogoTopBar(
                    title: "스테이지 생성(빠른 경기)",
                    onBackTap: () {
                      context.pop();
                    },
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 40,
                        children: [
                          StageBaseComponent(
                            title: '스테이지',
                            children: [
                              GogoTextField(
                                controller: _stageNameController,
                                hintText: "이름을 입력해주세요.",
                              ),
                              GogoTextField(
                                keyboardType: TextInputType.number,
                                inputFormatter: [
                                  FilteringTextInputFormatter(RegExp('[0-9]'),
                                      allow: true),
                                ],
                                controller: _stageBettingPointController,
                                hintText: "초기 보유 포인트",
                                endIcon: GogoIcons.pointCircle(
                                    color: GogoColors.gray400),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 16,
                            children: [
                              Text(
                                '경기',
                                style: GogoTypography.body2Extrabold
                                    .copyWith(color: GogoColors.white),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  spacing: 12,
                                  children: List.generate(
                                      GameType.values.length,
                                      (index) => GogoTagComponent(
                                            tagState: _matchGameType ==
                                                GameType.values[index],
                                            ontap: () {
                                              setState(() {
                                                _matchGameType =
                                                    GameType.values[index];
                                              });
                                            },
                                            color: GogoColors.main500,
                                            text: {
                                              GameType.SOCCER: "축구",
                                              GameType.BASKET_BALL: "농구",
                                              GameType.BASE_BALL: "야구",
                                              GameType.VOLLEY_BALL: "배구",
                                              GameType.BADMINTON: "배드민턴",
                                              GameType.LOL: "리그오브레전드",
                                              GameType.ETC: "기타",
                                            }[GameType.values[index]]!,
                                            icon: switch (
                                                GameType.values[index]) {
                                              GameType.SOCCER =>
                                                GogoIcons.football(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                              GameType.BASKET_BALL =>
                                                GogoIcons.basketball(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                              GameType.BASE_BALL =>
                                                GogoIcons.baseball(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                              GameType.VOLLEY_BALL =>
                                                GogoIcons.volleyball(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                              GameType.BADMINTON =>
                                                GogoIcons.badminton(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                              GameType.LOL =>
                                                GogoIcons.onlineGame(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                              GameType.ETC =>
                                                GogoIcons.volleyball(
                                                  color: _matchGameType ==
                                                          GameType.values[index]
                                                      ? GogoColors.white
                                                      : GogoColors.main500,
                                                  width: 12,
                                                  height: 12,
                                                ),
                                            },
                                          )),
                                ),
                              ),
                              Column(
                                spacing: 12,
                                children: [
                                  GogoTextField(
                                    controller: _matchNameController,
                                    hintText: "이름을 입력해주세요.",
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDropdownOpen =
                                            !isDropdownOpen; // Toggle dropdown 상태
                                      });
                                      final RenderBox renderBox = dropdownKey
                                          .currentContext!
                                          .findRenderObject() as RenderBox;
                                      position = renderBox.localToGlobal(
                                          Offset.zero); // 화면 상 절대 좌표
                                      print(
                                          "Dropdown 위치: ${position?.dx}, ${position?.dy}");
                                    },
                                    child: Container(
                                      key: dropdownKey,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                          color: GogoColors.gray700,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            switch (_matchGameSystem) {
                                              GameSystem.SINGLE => "단판",
                                              GameSystem.TOURNAMENT => "토너먼트",
                                              GameSystem.FULL_LEAGUE => "리그전",
                                              GameSystem.NULL => "없음",
                                              _ => "경기 방식",
                                            },
                                            style: GogoTypography.body3Semibold
                                                .copyWith(
                                                    color:
                                                        _matchGameSystem == null
                                                            ? GogoColors.gray400
                                                            : GogoColors.white),
                                          ),
                                          GogoIcons.chevronDown(
                                              color: _matchGameSystem == null
                                                  ? GogoColors.gray400
                                                  : GogoColors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                  GogoTextField(
                                    controller: TextEditingController(),
                                    hintText: "경기 최소 인원",
                                    endIcon: GogoIcons.person(
                                        color: GogoColors.gray400),
                                  ),
                                  GogoTextField(
                                    controller: TextEditingController(),
                                    hintText: "경기 최대 인원",
                                    endIcon: GogoIcons.person(
                                        color: GogoColors.gray400),
                                  ),
                                ],
                              )
                            ],
                          ),
                          StageBaseComponent(
                            title: '규칙',
                            children: [
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "최소 배팅 포인트",
                                endIcon: GogoIcons.pointCircle(
                                    color: GogoColors.gray400),
                              ),
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "최대 배팅 포인트",
                                endIcon: GogoIcons.pointCircle(
                                    color: GogoColors.gray400),
                              ),
                            ],
                          ),
                          StageBaseComponent(
                            title: '미니게임',
                            children: [
                              Container(
                                decoration: ShapeDecoration(
                                  color: GogoColors.gray700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 12, 0),
                                          child: GogoIcons.questionMarkCircle(
                                            color: GogoColors.gray500,
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          spacing: 16,
                                          children: [
                                            GogoIcons.pointCoin(
                                              width: 48,
                                              height: 48,
                                            ),
                                            Text(
                                              "코인토스",
                                              style: GogoTypography
                                                  .body1Semibold
                                                  .copyWith(
                                                      color:
                                                          GogoColors.gray400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                spacing: 16,
                                children: [
                                  Expanded(
                                    child: GogoTextField(
                                      controller: TextEditingController(),
                                      hintText: "최소 배팅 포인트",
                                      endIcon: GogoIcons.pointCircle(
                                          color: GogoColors.gray400),
                                    ),
                                  ),
                                  Expanded(
                                    child: GogoTextField(
                                      controller: TextEditingController(),
                                      hintText: "최대 배팅 포인트",
                                      endIcon: GogoIcons.pointCircle(
                                          color: GogoColors.gray400),
                                    ),
                                  ),
                                ],
                              ),
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "초기 보유 포인트",
                                endIcon:
                                    GogoIcons.ticket(color: GogoColors.gray400),
                              ),
                            ],
                          ),
                          StageBaseComponent(
                            title: '입장번호',
                            description: '입장 번호는 선택사항입니다.',
                            children: [
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "입장 번호 입력",
                              ),
                            ],
                          ),
                          StageBaseComponent(
                            title: '관리할 학생 (최대 5명)',
                            description: '관리할 학생은 선택사항입니다.',
                            children: [
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "본인과 함께 스테이지를 관리할 학생",
                              ),
                            ],
                          ),
                          GogoDefaultButton(
                            onTap: () {},
                            color:
                                true ? GogoColors.gray400 : GogoColors.main600,
                            text: "확인",
                          ),
                          SizedBox(height: 75),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isDropdownOpen)
            Positioned(
              top: position?.dy ?? 0 + 30, // null 안전 처리
              child: Container(
                width: dropdownKey.currentContext?.size?.width,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000),
                      blurRadius: 9,
                    ),
                  ],
                  color: GogoColors.gray700,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 정보수정 버튼 클릭 이벤트 처리
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          '정보수정',
                          style: GogoTypography.body3Semibold.copyWith(
                            color: GogoColors.white,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        // 회원 탈퇴 버튼 클릭 이벤트 처리
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          '회원 탈퇴',
                          style: GogoTypography.body3Semibold.copyWith(
                            color: GogoColors.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
