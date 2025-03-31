import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';

import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';
import '../widgets/stage_base_component.dart';

class StageCreateScreen extends StatelessWidget {
  const StageCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller: TextEditingController(),
                            hintText: "이름을 입력해주세요.",
                          ),
                          GogoTextField(
                            controller: TextEditingController(),
                            hintText: "초기 보유 포인트",
                            endIcon:
                                GogoIcons.pointCircle(color: GogoColors.gray400),
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
                          Row(
                            children: [],
                          ),
                          Column(
                            spacing: 12,
                            children: [
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "이름을 입력해주세요.",
                              ),
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "경기 방식",
                                endIcon: GogoIcons.chevronDown(
                                    color: GogoColors.gray400),
                              ),
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "경기 최소 인원",
                                endIcon:
                                    GogoIcons.person(color: GogoColors.gray400),
                              ),
                              GogoTextField(
                                controller: TextEditingController(),
                                hintText: "경기 최대 인원",
                                endIcon:
                                    GogoIcons.person(color: GogoColors.gray400),
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
                            endIcon:
                                GogoIcons.pointCircle(color: GogoColors.gray400),
                          ),
                          GogoTextField(
                            controller: TextEditingController(),
                            hintText: "최대 배팅 포인트",
                            endIcon:
                                GogoIcons.pointCircle(color: GogoColors.gray400),
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
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  SizedBox(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 12, 0),
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
                                          style: GogoTypography.body1Semibold
                                              .copyWith(
                                                  color: GogoColors.gray400),
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
                            endIcon: GogoIcons.ticket(color: GogoColors.gray400),
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
    );
  }
}
