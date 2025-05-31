import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_state.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_select_component.dart';

class MinigameScreen extends StatelessWidget {

  final int stageId;
  final int point;

  const MinigameScreen({
    super.key,
    required this.stageId,
    required this.point,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MinigameDescriptionBloc()),
        BlocProvider(create: (context) => MinigameBloc()..add(FetchMinigameInfo(stageId: stageId))),
      ],
      child: BlocListener<MinigameBloc, MinigameState>(
        listener: (context, state) {
          if (state is TicketPurchaseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '티켓 구매가 완료되었습니다!',
                  style: GogoTypography.body3Semibold.copyWith(color: GogoColors.white),
                ),
                backgroundColor: GogoColors.main600,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is TicketPurchaseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '티켓 구매에 실패했습니다: ${state.message}',
                  style: GogoTypography.body3Semibold.copyWith(color: GogoColors.white),
                ),
                backgroundColor: GogoColors.teamRed,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<MinigameBloc, MinigameState>(
          buildWhen: (previous, current) {
            // TicketPurchase 상태는 UI rebuild를 하지 않음 (Listener에서 처리)
            return current is! TicketPurchaseSuccess && current is! TicketPurchaseError;
          },
          builder: (context, state) {
            if(state is MinigameInfoLoading) {
              return LoadingPage();
            }

            else if(state is MinigameInfoLoaded) {
              return Scaffold(
                body: ListView(
                  children: [
                    // 티켓 정보 및 구매
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: MinigameScrollComponent(
                        stageId: stageId,
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
                              height: 21.h,
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
                                    '${state.ticketCountsResponse.yavarwee}',
                                    style: GogoTypography.body3Semibold.copyWith(
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
                                    '${state.ticketCountsResponse.coinToss}',
                                    style: GogoTypography.body3Semibold.copyWith(
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
                                    '${state.ticketCountsResponse.plinko}',
                                    style: GogoTypography.body3Semibold.copyWith(
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
                    // 포인트 정보 및 게임화면으로 이동
                    MinigameScrollComponent(
                      stageId: stageId,
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
                                '$point',
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
                      shellgameTicketscost: state.shopTicketStatusResponse.yavarwee.ticketPrice,
                      cointTossTicketscost: state.shopTicketStatusResponse.coinToss.ticketPrice,
                      plinkoTicketscost: state.shopTicketStatusResponse.plinko.ticketPrice,
                      shellgameTicketsCount: state.shopTicketStatusResponse.yavarwee.ticketQuantity,
                      cointTossTicketsCount: state.shopTicketStatusResponse.coinToss.ticketQuantity,  
                      plinkoTicketsCount: state.shopTicketStatusResponse.plinko.ticketQuantity,
                    ),
                  ],
                ),
              );
            }

            else if(state is MinigameInfoError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const SizedBox.shrink();
          }
        ),
      ),
    );
  }
}
