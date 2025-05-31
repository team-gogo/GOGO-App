import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/data/models/shop/enum_type/ticket_type.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_bloc.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_event.dart';
import 'package:gogo_app/presentation/minigame/bloc/minigame_bloc/minigame_state.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_description_popup.dart';
import 'package:gogo_app/presentation/minigame/widgets/minigame_topbar.dart';
import 'package:gogo_app/router.dart';

class MinigameSelectComponent extends StatelessWidget {
  final Widget gameIcon;
  final String gameName;
  final int ticketsCost;
  final int ticketsCount;
  final VoidCallback onTap;
  final bool info; // 티켓 정보이면 true, 미니게임이면 false
  final int? userPoint; // 사용자 보유 포인트
  final int? userTicketCount; // 사용자 보유 티켓 수
  final bool? isGameActive; // 게임 활성화 여부

  const MinigameSelectComponent({
    super.key,
    required this.gameIcon,
    required this.gameName,
    required this.ticketsCost,
    this.ticketsCount = 0,
    required this.info,
    required this.onTap,
    this.userPoint,
    this.userTicketCount,
    this.isGameActive,
  });

  bool get _isButtonEnabled {
    if (info) {
      // 게임하기 버튼: 티켓이 있고 게임이 활성화되어야 함
      final hasTickets = (userTicketCount ?? 0) > 0;
      final gameIsActive = isGameActive ?? true; // 기본값 true
      return hasTickets && gameIsActive;
    } else {
      // 티켓 구매 버튼: 포인트가 충분하고 구매 가능한 티켓이 있어야 함
      final hasEnoughPoints = (userPoint ?? 0) >= ticketsCost;
      final hasAvailableTickets = ticketsCount > 0;
      return hasEnoughPoints && hasAvailableTickets;
    }
  }

  String get _buttonText {
    if (info) {
      // 게임하기 버튼
      return "게임하기";
    } else {
      // 티켓 구매 버튼
      return '${ticketsCost}P';
    }
  }

  Color get _buttonColor {
    return _isButtonEnabled ? GogoColors.main600 : GogoColors.gray600;
  }

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
                color: _buttonColor,
              ),
              child: TextButton(
                onPressed: _isButtonEnabled ? onTap : null,
                child: Text(
                  _buttonText,
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: _isButtonEnabled
                        ? GogoColors.white
                        : GogoColors.gray400,
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

class MinigameScrollComponent extends StatelessWidget {
  final Widget component;
  final Widget icon;
  final String text;
  final int stageId;
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
    required this.stageId,
    this.shellgameTicketscost = 0,
    this.cointTossTicketscost = 0,
    this.plinkoTicketscost = 0,
    this.shellgameTicketsCount = 0,
    this.cointTossTicketsCount = 0,
    this.plinkoTicketsCount = 0,
    required this.info,
  });

  void _purchaseTicket(
      BuildContext context, TicketType ticketType, int stageId) {
    context.read<MinigameBloc>().add(
          PurchaseTicket(
            stageId: stageId,
            ticketType: ticketType,
            quantity: 1, // 기본 1개 구매
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinigameBloc, MinigameState>(
      builder: (context, state) {
        // 사용자 포인트와 티켓 정보를 state에서 가져오기
        int? userPoint;
        int? yavarweeTickets;
        int? coinTossTickets;
        int? plinkoTickets;
        bool? isYavarweeActive;
        bool? isCoinTossActive;
        bool? isPlinkoActive;

        if (state is MinigameInfoLoaded) {
          userPoint = state.userPointResponse.point;
          yavarweeTickets = state.ticketCountsResponse.yavarwee;
          coinTossTickets = state.ticketCountsResponse.coinToss;
          plinkoTickets = state.ticketCountsResponse.plinko;
          isYavarweeActive = state.activeGameResponse.isYavarweeActive;
          isCoinTossActive = state.activeGameResponse.isCoinTossActive;
          isPlinkoActive = state.activeGameResponse.isPlinkoActive;
        }

        return Column(
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
              userPoint: userPoint,
              userTicketCount: yavarweeTickets,
              isGameActive: isYavarweeActive,
              onTap: info
                  ? () => context.pushNamed(PageRouter.yavarwee)
                  : () =>
                      _purchaseTicket(context, TicketType.WAVARWEE, stageId),
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
              userPoint: userPoint,
              userTicketCount: coinTossTickets,
              isGameActive: isCoinTossActive,
              onTap: info
                  ? () => context.pushNamed(PageRouter.coinToss)
                  : () =>
                      _purchaseTicket(context, TicketType.COINTOSS, stageId),
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
              userPoint: userPoint,
              userTicketCount: plinkoTickets,
              isGameActive: isPlinkoActive,
              onTap: info
                  ? () {}
                  : () => _purchaseTicket(context, TicketType.PLINKO, stageId),
            ),
          ],
        );
      },
    );
  }
}
