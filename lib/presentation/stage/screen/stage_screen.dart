import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/stage/stage_card_component.dart';
import 'package:gogo_app/design_system/component/tag/tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '참여한 스테이지',
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: GogoColors.white),
                      ),
                      GestureDetector(
                        child: TagComponent(
                          color: GogoColors.main400,
                          padding: const EdgeInsets.all(12.0),
                          borderRadius: BorderRadius.circular(8),
                          text: '스테이지 생성',
                          icon: GogoIcons.plusCircle(
                            color: GogoColors.main400,
                            width: 16,
                            height: 16,
                          ),
                          textStyle: GogoTypography.caption2Semibold,
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StageCardComponent(
                          width: 400,
                          stageName: '스테이지 이름',
                          color: GogoColors.gray700,
                          official: true,
                          recruiting: true,
                          manager: true,
                          broadcast: true,
                          onTap: () {},
                          buttonText: '참여하기',
                          buttonIcon: Container(),
                        ),
                        StageCardComponent(
                          width: 400,
                          stageName: '스테이지 이름',
                          color: GogoColors.gray700,
                          official: true,
                          recruiting: true,
                          manager: true,
                          broadcast: true,
                          onTap: () {},
                          buttonText: '참여하기',
                          buttonIcon: Container(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '참여가능한 스테이지',
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StageCardComponent(
                          width: 400,
                          stageName: '스테이지 이름',
                          color: GogoColors.gray700,
                          official: true,
                          recruiting: false,
                          manager: false,
                          broadcast: true,
                          onTap: () {},
                          buttonText: '참여하기',
                          buttonIcon: Container(),
                        ),
                        StageCardComponent(
                          width: 400,
                          stageName: '스테이지 이름',
                          color: GogoColors.gray700,
                          official: true,
                          recruiting: false,
                          manager: false,
                          broadcast: true,
                          onTap: () {},
                          buttonText: '참여하기',
                          buttonIcon: Container(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '모집중인 스테이지',
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StageCardComponent(
                          width: 400,
                          stageName: '스테이지 이름',
                          color: GogoColors.gray700,
                          official: true,
                          recruiting: true,
                          manager: true,
                          broadcast: false,
                          onTap: () {},
                          buttonText: '참여하기',
                          buttonIcon: Container(),
                        ),
                        StageCardComponent(
                          width: 400,
                          stageName: '스테이지 이름',
                          color: GogoColors.gray700,
                          official: true,
                          recruiting: true,
                          manager: true,
                          broadcast: true,
                          onTap: () {},
                          buttonText: '참여하기',
                          buttonIcon: Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
