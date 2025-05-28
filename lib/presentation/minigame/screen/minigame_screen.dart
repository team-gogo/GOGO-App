import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_select_component.dart';

class MinigameScreen extends StatelessWidget {
  const MinigameScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MinigameDescriptionBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GogoTopBar(
                      title: '뒤로가기', onBackTap: () => context.pop(context))),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: MinigameScrollComponent(
                        icon: GogoIcons.arcade(
                          color: GogoColors.white,
                        ),
                        info: true,
                        text: "게임",
                        component: Row(
                          spacing: 12,
                          children: [
                            Text(
                              "티켓",
                              style: GogoTypography.caption1Semibold.copyWith(
                                color: GogoColors.white,
                              ),
                            ),
                            Container(
                              color: GogoColors.gray600,
                              height: 21,
                              width: 1,
                            ),
                            SizedBox(
                              child: Row(
                                spacing: 10,
                                children: [
                                  GogoIcons.shellGame(
                                    width: 20,
                                    height: 20,
                                    color: GogoColors.white,
                                  ),
                                  Text(
                                    '0',
                                    style:
                                        GogoTypography.body3Semibold.copyWith(
                                      color: GogoColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                spacing: 10,
                                children: [
                                  GogoIcons.pointCoin(
                                    width: 20,
                                    height: 20,
                                    color: GogoColors.white,
                                  ),
                                  Text(
                                    '2',
                                    style:
                                        GogoTypography.body3Semibold.copyWith(
                                      color: GogoColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                spacing: 10,
                                children: [
                                  GogoIcons.shellGame(
                                    width: 20,
                                    height: 20,
                                    color: GogoColors.white,
                                  ),
                                  Text(
                                    '0',
                                    style:
                                        GogoTypography.body3Semibold.copyWith(
                                      color: GogoColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MinigameScrollComponent(
                      icon: GogoIcons.shop(
                        color: GogoColors.white,
                      ),
                      info: false,
                      text: "상점",
                      component: Row(
                        spacing: 12,
                        children: [
                          Text(
                            "보유 포인트",
                            style: GogoTypography.caption1Semibold.copyWith(
                              color: GogoColors.white,
                            ),
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Text(
                                '2000',
                                style: GogoTypography.caption1Semibold.copyWith(
                                  color: GogoColors.white,
                                ),
                              ),
                              GogoIcons.pointCircle(
                                color: GogoColors.white,
                                width: 16,
                                height: 16,
                              )
                            ],
                          )
                        ],
                      ),
                      shellgameTicketscost: 1000,
                      cointTossTicketscost: 1000,
                      plinkoTicketscost: 1000,
                      shellgameTicketsCount: 5,
                      cointTossTicketsCount: 5,
                      plinkoTicketsCount: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
