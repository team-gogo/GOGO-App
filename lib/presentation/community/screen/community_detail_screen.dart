import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
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
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        minimum: EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GogoTopBar(
                      title: '뒤로가기',
                      onBackTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: GogoColors.gray700,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GogoTagComponent(
                                color: GogoColors.main500,
                                text: "배드민턴",
                                icon: GogoIcons.badminton(
                                  color: GogoColors.main500,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                '스테이지 이름',
                                style:
                                    GogoTypography.caption2Extrabold.copyWith(
                                  color: GogoColors.gray300,
                                ),
                              ),
                              SizedBox(width: 8),
                              Row(
                                children: [
                                  GogoIcons.person(color: GogoColors.gray300),
                                  SizedBox(width: 4),
                                  Text(
                                    '디자인',
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Text(
                            '오늘 너무 디자인 하기 싫음',
                            style: GogoTypography.caption1Extrabold.copyWith(
                              color: GogoColors.white,
                            ),
                          ),
                          Text(
                            '오늘 너무 갑자기 하기 싫어짐 어떡함? 그냥 갈아 엎을까? 해결책 좀 ㄹㅇ....',
                            style: GogoTypography.caption2Semibold.copyWith(
                              color: GogoColors.gray400,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GogoIcons.speechBubble(
                                      color: GogoColors.gray300),
                                  SizedBox(width: 4),
                                  Text(
                                    '4',
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GogoIcons.heartOutlined(
                                      color: GogoColors.gray300),
                                  SizedBox(width: 4),
                                  Text(
                                    '13',
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '2025-03-08',
                                style: GogoTypography.caption2Semibold.copyWith(
                                  color: GogoColors.gray500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '댓글',
                      style: GogoTypography.body2Extrabold.copyWith(
                        color: GogoColors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 12,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: double.infinity,
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
                                  SizedBox(width: 4),
                                  Text(
                                    '김진원',
                                    style: GogoTypography.caption1Semibold
                                        .copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      '그냥 디자이너 접으셈 3D로 ㄱㄱ',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GogoTypography.caption3Semibold
                                          .copyWith(
                                        color: GogoColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GogoIcons.heartOutlined(
                                    color: GogoColors.gray300,
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '14',
                                    style:
                                        GogoTypography.body3Semibold.copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 12);
                      },
                    ),
                  ],
                ),
              ),
            ),
            GogoTextField(
              controller: controller,
              hintText: '댓글을 입력해주세요',
              endIcon: GogoIcons.send(
                color: GogoColors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
