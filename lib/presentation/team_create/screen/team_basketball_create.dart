import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/theme/icon.dart';

import '../../../design_system/component/button/gogo_default_button.dart';
import '../../../design_system/component/top_bar/gogo_top_bar.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';

class TeamBasketballCreate extends StatelessWidget {
  const TeamBasketballCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 17, 16, 95),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 36,
            children: [
              GogoTopBar(
                title: '팀 생성',
                onBackTap: () => context.pop(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '경기 이름',
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
              Center(child: GogoIcons.basketballMap(width: 343, height: 373)),
              Spacer(),
              GogoDefaultButton(onTap: () {}, text: '확인')
            ],
          ),
        ),
      ),
    );
  }
}
