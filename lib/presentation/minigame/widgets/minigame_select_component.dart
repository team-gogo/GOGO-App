import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_description_popup.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_topbar.dart';
import 'package:gogo_app/router.dart';

class MinigameScrollComponent extends StatelessWidget {
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

  const MinigameScrollComponent({
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MinigameTopBar(
            height: 32,
            component: component,
            icon: icon,
            text: text,
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
            onTap: () => info ? context.pushNamed(PageRouter.yavarwee) : () {},
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
            onTap: () => info ? context.pushNamed(PageRouter.coinToss) : () {},
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
            gameName: "플린코",
            ticketsCost: plinkoTicketscost,
            ticketsCount: plinkoTicketsCount,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class MinigameSelectComponent extends StatelessWidget {
  final Widget gameIcon;
  final String gameName;
  final int ticketsCost;
  final int ticketsCount;
  final VoidCallback onTap;
  final bool info;

  const MinigameSelectComponent({
    super.key,
    required this.gameIcon,
    required this.gameName,
    required this.ticketsCost,
    this.ticketsCount = 0,
    required this.info,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: GogoColors.gray700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                right: 14,
                top: 12,
                child: GogoIcons.questionMarkCircle(
                  onTap: () {
                    context
                        .read<MinigameDescriptionBloc>()
                        .add(ChangeCategory(minigameName: gameName));
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogcontext) {
                        return BlocProvider.value(
                          value:
                              BlocProvider.of<MinigameDescriptionBloc>(context),
                          child:
                              MinigameDescriptionPopup(minigameName: gameName),
                        );
                      },
                    );
                  },
                  color: GogoColors.gray500,
                ),
              ),
            ],
          ),
        ),
        Column(
          spacing: 8,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GogoColors.main600,
              ),
              child: TextButton(
                onPressed: onTap,
                child: Text(
                  info ? "게임하기" : '${ticketsCost}P',
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
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
      ],
    );
  }
}
