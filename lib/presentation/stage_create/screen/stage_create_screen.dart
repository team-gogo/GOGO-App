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
  const StageCreateScreen({super.key});

  @override
  State<StageCreateScreen> createState() => _StageCreateScreenState();
}

class _StageCreateScreenState extends State<StageCreateScreen> {
  OverlayEntry? _matchGameSystemDropdown;
  final LayerLink _matchGameSystemDropdownLink = LayerLink();

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

  bool _selectCoinToss = false;

  final TextEditingController _coinTossRuleMinimumNumberBettingPointController =
      TextEditingController();

  final TextEditingController _coinTossRuleMaximumNumberBettingPointController =
      TextEditingController();

  final TextEditingController _coinTossBettingTicketController =
      TextEditingController();

  final TextEditingController _admissionNumberController =
      TextEditingController();

  final List<int> _studentsManage = [];

  void _insertMatchSystemDropdown() {
    removeMatchSystemDropdown();
    assert(_matchGameSystemDropdown == null);
    _matchGameSystemDropdown = OverlayEntry(
        builder: (builder) => Positioned(
              width: _matchGameSystemDropdownLink.leaderSize?.width,
              child: CompositedTransformFollower(
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                link: _matchGameSystemDropdownLink,
                child: Material(
                  color: GogoColors.gray700,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: GogoColors.gray700,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Color(0x3F000000), blurRadius: 18)
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      spacing: 12,
                      children: List.generate(
                        4,
                        (index) => matchSystemDropdownItem(
                          GameSystem.values[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));

    Overlay.of(context).insert(_matchGameSystemDropdown!);
  }

  Widget matchSystemDropdownItem(GameSystem system) => GestureDetector(
        onTap: () {
          setState(() => _matchGameSystem = system);
          removeMatchSystemDropdown();
        },
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text(
                switch (system) {
                  GameSystem.SINGLE => "단판",
                  GameSystem.TOURNAMENT => "토너먼트",
                  GameSystem.FULL_LEAGUE => "리그전",
                  GameSystem.NULL => "없음",
                },
                style: GogoTypography.body3Extrabold.copyWith(
                    color: _matchGameSystem == system
                        ? GogoColors.white
                        : GogoColors.gray400),
              ),
              Container(
                width: double.infinity,
                color: GogoColors.gray600,
                height: 1,
              )
            ],
          ),
        ),
      );

  void removeMatchSystemDropdown() {
    _matchGameSystemDropdown?.remove();
    _matchGameSystemDropdown = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        removeMatchSystemDropdown();
      },
      child: Scaffold(
        body: SafeArea(
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
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter()
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
                                    _matchGameSystemDropdown == null
                                        ? _insertMatchSystemDropdown()
                                        : removeMatchSystemDropdown();
                                  },
                                  child: CompositedTransformTarget(
                                    link: _matchGameSystemDropdownLink,
                                    child: Container(
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
                                ),
                                GogoTextField(
                                  controller:
                                      _matchMinimumNumberPlayersController,
                                  hintText: "경기 최소 인원",
                                  endIcon: GogoIcons.person(
                                      color: GogoColors.gray400),
                                ),
                                GogoTextField(
                                  controller:
                                      _matchMaximumNumberPlayersController,
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
                              controller:
                                  _ruleMinimumNumberBettingPointController,
                              hintText: "최소 배팅 포인트",
                              endIcon: GogoIcons.pointCircle(
                                  color: GogoColors.gray400),
                            ),
                            GogoTextField(
                              controller:
                                  _ruleMaximumNumberBettingPointController,
                              hintText: "최대 배팅 포인트",
                              endIcon: GogoIcons.pointCircle(
                                  color: GogoColors.gray400),
                            ),
                          ],
                        ),
                        StageBaseComponent(
                          title: '미니게임',
                          children: [
                            GestureDetector(
                              onTap: () => setState(
                                () => _selectCoinToss = !_selectCoinToss,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: GogoColors.gray700,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _selectCoinToss
                                        ? GogoColors.main500
                                        : GogoColors.gray700,
                                    width: 4,
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
                                                color: _selectCoinToss
                                                    ? GogoColors.main500
                                                    : GogoColors.gray400),
                                            Text(
                                              "코인토스",
                                              style: GogoTypography
                                                  .body1Semibold
                                                  .copyWith(
                                                      color: _selectCoinToss
                                                          ? GogoColors.main500
                                                          : GogoColors.gray400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              spacing: 16,
                              children: [
                                Expanded(
                                  child: GogoTextField(
                                    controller:
                                        _coinTossRuleMinimumNumberBettingPointController,
                                    hintText: "최소 배팅 포인트",
                                    hintStyle: GogoTypography.caption1Semibold
                                        .copyWith(color: GogoColors.gray400),
                                    endIcon: GogoIcons.pointCircle(
                                        color: GogoColors.gray400),
                                  ),
                                ),
                                Expanded(
                                  child: GogoTextField(
                                    controller:
                                        _coinTossRuleMaximumNumberBettingPointController,
                                    hintText: "최대 배팅 포인트",
                                    hintStyle: GogoTypography.caption1Semibold
                                        .copyWith(color: GogoColors.gray400),
                                    endIcon: GogoIcons.pointCircle(
                                        color: GogoColors.gray400),
                                  ),
                                ),
                              ],
                            ),
                            GogoTextField(
                              controller: _coinTossBettingTicketController,
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
                              controller: _admissionNumberController,
                              hintText: "입장 번호 입력",
                            ),
                          ],
                        ),
                        StageBaseComponent(
                          title: '관리할 학생 (최대 5명)',
                          description: '관리할 학생은 선택사항입니다.',
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                  color: GogoColors.gray700,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                '본인과 함께 스테이지를 관리할 학생',
                                style: GogoTypography.body3Semibold
                                    .copyWith(color: GogoColors.gray400),
                              ),
                            )
                          ],
                        ),
                        GogoDefaultButton(
                          onTap: () {},
                          color: true ? GogoColors.gray400 : GogoColors.main600,
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
      ),
    );
  }
}
