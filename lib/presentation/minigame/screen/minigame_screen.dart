import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_play_component.dart';

class MinigameScreen extends StatelessWidget {
  final int shellgameTickets; // 야바위 티켓수
  final int cointTossTickets; // 코인토스 티켓수
  final int plinkoTickets; // 플링코 티켓수
  final int shellgameTicketsCount; // 야바위 티켓 구매 가능한 수수
  final int cointTossTicketsCount; // 코인토스 티켓 구매 가능한 수
  final int plinkoTicketsCount; // 야바위 티켓 구매 가능한 수
  final int shellgameTicketscost; // 코인토스 티켓 가격
  final int cointTossTicketscost; // 플링코 티켓 가격
  final int plinkoTicketscost; // 야바위 티켓 가격
  final int point; // 보유 포인트

  const MinigameScreen({
    required this.shellgameTickets,
    required this.cointTossTickets,
    required this.plinkoTickets,
    required this.shellgameTicketsCount,
    required this.cointTossTicketsCount,
    required this.plinkoTicketsCount,
    required this.shellgameTicketscost,
    required this.cointTossTicketscost,
    required this.plinkoTicketscost,
    required this.point,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            // 티켓 정보 및 구매
            MinigameComponent(
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
                  Divider(
                    height: 21.h,
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
                          '$shellgameTickets',
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
                          '$cointTossTickets',
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
                          '$shellgameTickets',
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
            // 포인트 정보 및 게임화면으로 이동
            MinigameComponent(
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
                  Container(
                    child: Row(
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
                    ),
                  )
                ],
              ),
              shellgameTicketscost: shellgameTicketscost,
              cointTossTicketscost: cointTossTicketscost,
              plinkoTicketscost: plinkoTicketscost,
              shellgameTicketsCount: shellgameTicketsCount,
              cointTossTicketsCount: cointTossTicketsCount,
              plinkoTicketsCount: plinkoTicketsCount,
            ),
          ],
        ),
      ),
    );
  }
}

// 미니게임 정보 공통 컴포넌트

class MinigameSelectComponent extends StatelessWidget {
  final double width;
  final double height;
  final Widget gameIcon;
  final String gameName;
  final int ticketsCost;
  final int ticketsCount;
  final bool info; // 티켓 정보이면 true, 미니게임이면 false,

  const MinigameSelectComponent({
    super.key,
    this.width = 343,
    this.height = 143,
    required this.gameIcon,
    required this.gameName,
    required this.ticketsCost,
    this.ticketsCount = 0,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 16.h, children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: GogoColors.gray700, borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Center(
              child: Column(
                spacing: 16,
                children: [
                  gameIcon,
                  Text(
                    gameName,
                    style: GogoTypography.body1Semibold.copyWith(
                      color: GogoColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 0,
                child: GogoIcons.questionMarkCircle(
                  onTap: () {},
                  color: GogoColors.gray500,
                )),
          ],
        ),
      ),
      Column(
        spacing: 8,
        children: [
          Container(
              width: width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GogoColors.main600,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  info ? "게임하기" : '$ticketsCost',
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
              )),
          info
              ? Container()
              : Text(
                  '구매 가능한 티켓 : $ticketsCount',
                  style: GogoTypography.caption2Semibold.copyWith(
                    color: GogoColors.gray500,
                  ),
                ),
        ],
      ),
      SizedBox(
        height: 12,
      ),
    ]);
  }
}

// 미니게임 공통 탑바

class MinigameTopBar extends StatelessWidget {
  final double width;
  final double height;
  final Widget icon;
  final String text;
  final Widget component;

  const MinigameTopBar({
    this.width = 343,
    required this.height,
    required this.icon,
    required this.text,
    required this.component,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 67.w,
            height: height,
            child: Row(
              spacing: 8.w,
              children: [
                icon,
                Text(
                  text,
                  style: GogoTypography.body2Extrabold.copyWith(
                    color: GogoColors.white,
                  ),
                ),
              ],
            ),
          ),
          component,
        ],
      ),
    );
  }
}

// 미니게임 공통 컴포넌트를 모아둔 Column

class MinigameComponent extends StatelessWidget {
  final Widget component;
  final Widget icon;
  final String text;
  final int shellgameTicketscost; // 코인토스 티켓 가격
  final int cointTossTicketscost; // 플링코 티켓 가격
  final int plinkoTicketscost; // 야바위 티켓 가격
  final int shellgameTicketsCount; // 야바위 티켓 구매 가능한 수수
  final int cointTossTicketsCount; // 코인토스 티켓 구매 가능한 수
  final int plinkoTicketsCount; // 야바위 티켓 구매 가능한 수
  final bool info; // 티켓이면 true, 포인트 정보이면 false

  const MinigameComponent({
    super.key,
    required this.component,
    required this.icon,
    required this.text,
    this.shellgameTicketscost = 0,
    this.cointTossTicketscost = 0,
    this.plinkoTicketscost = 0,
    this.shellgameTicketsCount = 0,
    this.cointTossTicketsCount = 0,
    this.plinkoTicketsCount = 0,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MinigameTopBar(
          height: 32,
          component: component,
          icon: icon,
          text: text,
        ),
        SizedBox(
          height: 12,
        ),
        MinigameSelectComponent(
          info: info,
          gameIcon: info
              ? GogoIcons.shellGame(
                  width: 48,
                  height: 48,
                  color: GogoColors.white,
                )
              : GogoIcons.ticket(
                  width: 48,
                  height: 48,
                  color: GogoColors.white,
                ),
          gameName: "야바위",
          ticketsCost: shellgameTicketscost,
          ticketsCount: shellgameTicketsCount,
        ),
        MinigameSelectComponent(
          info: info,
          gameIcon: info
              ? GogoIcons.pointCoin(
                  width: 48,
                  height: 48,
                  color: GogoColors.white,
                )
              : GogoIcons.ticket(
                  width: 48,
                  height: 48,
                  color: GogoColors.white,
                ),
          gameName: "코인토스",
          ticketsCost: cointTossTicketscost,
          ticketsCount: cointTossTicketsCount,
        ),
        MinigameSelectComponent(
          info: info,
          gameIcon: info
              ? GogoIcons.plinko(
                  width: 48,
                  height: 48,
                  color: GogoColors.white,
                )
              : GogoIcons.ticket(
                  width: 48,
                  height: 48,
                  color: GogoColors.white,
                ),
          gameName: "플링코",
          ticketsCost: plinkoTicketscost,
          ticketsCount: plinkoTicketsCount,
        ),
      ],
    );
  }
}

// 미니게임 탑바 티켓

class MinigameTicket extends StatelessWidget {
  final int tickets;
  final Widget gameIcon;

  const MinigameTicket({
    required this.tickets,
    required this.gameIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        gameIcon,
        Text(
          '$tickets',
          style: GogoTypography.body3Semibold,
        ),
      ],
    );
  }
}
