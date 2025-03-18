import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import '../../../design_system/component/stage/gogo_stage_card_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 40,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '참여한 스테이지',
                        style: GogoTypography.body2Extrabold
                            .copyWith(color: GogoColors.white),
                      ),
                      GestureDetector(
                        child: GogoTagComponent(
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
                ),
                SingleChildScrollView(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      GogoStageCardComponent(
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
                      GogoStageCardComponent(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Padding(
                  padding: padding,
                  child: Text(
                    '참여가능한 스테이지',
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                ),
                SingleChildScrollView(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      GogoStageCardComponent(
                        stageName: '스테이지 이름',
                        color: GogoColors.gray700,
                        official: true,
                        recruiting: false,
                        manager: false,
                        broadcast: true,
                        onTap: () {},
                        buttonText: '인증번호로 참여하기',
                        buttonIcon: GogoIcons.lock(
                          height: 20.sp,
                          width: 20.sp,
                          color: GogoColors.white,
                        ),
                      ),
                      GogoStageCardComponent(
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
              ],
            ),
            Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: padding,
                  child: Text(
                    '모집중인 스테이지',
                    style: GogoTypography.body2Extrabold
                        .copyWith(color: GogoColors.white),
                  ),
                ),
                SingleChildScrollView(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    children: [
                      GogoStageCardComponent(
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
                      GogoStageCardComponent(
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
          ],
        ),
      ),
    );
  }
}
