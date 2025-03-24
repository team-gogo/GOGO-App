import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class CommunityDeatilScreen extends StatelessWidget {
  final String sport;
  final String stageName;
  final String user;
  final String title;
  final String content;
  final int heartCount;
  final int commentCount;
  final String date;

  const CommunityDeatilScreen({
    required this.sport,
    required this.stageName,
    required this.user,
    required this.title,
    required this.content,
    required this.heartCount,
    required this.commentCount,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.all(14),
        child: Column(
          children: [
            SizedBox(
              height: 768.h,
              child: ListView(
                children: [
                  GogoTopBar(
                    title: '커뮤니티 글 보기',
                    onBackTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: 343,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: GogoColors.gray700,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            GogoTagComponent(
                              color: GogoColors.main500,
                              text: "배드민턴", // sport
                              icon: GogoIcons.badminton(
                                color: GogoColors.main500,
                              ),
                            ),
                            Text(
                              '스테이지 이름', // stageName
                              style: GogoTypography.caption2Extrabold.copyWith(
                                color: GogoColors.gray300,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                spacing: 8,
                                children: [
                                  GogoIcons.person(
                                    color: GogoColors.gray300,
                                  ),
                                  Text(
                                    '디자인', // user
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          '오늘 너무 디자인 하기 싫음', // title
                          style: GogoTypography.caption1Extrabold.copyWith(
                            color: GogoColors.white,
                          ),
                        ),
                        Text(
                          '오늘 너무 갑자기 하기 싫어짐 어떡함? 그냥 갈아 엎을까? 해결 책 좀 ㄹㅇ....',
                          style: GogoTypography.caption2Semibold.copyWith(
                            color: GogoColors.gray400,
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Row(
                                  spacing: 4,
                                  children: [
                                    GogoIcons.speechBubble(
                                      color: GogoColors.gray300,
                                      width: 16,
                                      height: 16,
                                    ),
                                    Text(
                                      '13', // commentCount
                                      style: GogoTypography.caption2Semibold
                                          .copyWith(
                                        color: GogoColors.gray300,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 8,
                                  children: [
                                    GogoIcons.heartOutlined(
                                      color: GogoColors.gray300,
                                      width: 16,
                                      height: 16,
                                    ),
                                    Text(
                                      '4', // heartCount
                                      style: GogoTypography.caption2Semibold
                                          .copyWith(
                                        color: GogoColors.gray300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              '2025-03-08', // date
                              style: GogoTypography.caption2Semibold.copyWith(
                                color: GogoColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '댓글',
                    style: GogoTypography.body2Extrabold.copyWith(
                      color: GogoColors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 344,
                        height: 56,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: GogoColors.gray700,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GogoIcons.person(
                                  width: 20,
                                  height: 20,
                                  color: GogoColors.gray300,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '김진원', // 댓글 작성한 사람,
                                  style:
                                      GogoTypography.caption1Semibold.copyWith(
                                    color: GogoColors.gray300,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '그냥 디자이너 접으셈 3D로 ㄱㄱdddddddddd',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
