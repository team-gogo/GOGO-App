import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class CommunityDetailScreen extends StatelessWidget {
  final SearchCommunityDetailResponse post;

  const CommunityDetailScreen({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    Widget CommentList(Comment comment) {
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
                  comment.author.name,
                  style: GogoTypography.caption1Semibold.copyWith(
                    color: GogoColors.gray300,
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 150,
                  child: Text(
                    comment.comment,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GogoTypography.caption3Semibold.copyWith(
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
                  comment.likeCount.toString(),
                  style: GogoTypography.body3Semibold.copyWith(
                    color: GogoColors.gray300,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        minimum: EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 210.h,
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
                                text: post.stage.name,
                                icon: GogoIcons.badminton(
                                  color: GogoColors.main500,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                post.stage.category.toString(),
                                style:
                                    GogoTypography.caption2Extrabold.copyWith(
                                  color: GogoColors.gray300,
                                ),
                              ),
                              SizedBox(width: 12),
                              Row(
                                children: [
                                  GogoIcons.person(color: GogoColors.gray300),
                                  SizedBox(width: 4),
                                  Text(
                                    post.author.name,
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
                            post.title,
                            style: GogoTypography.caption1Extrabold.copyWith(
                              color: GogoColors.white,
                            ),
                          ),
                          Text(
                            post.content,
                            style: GogoTypography.caption2Semibold.copyWith(
                              color: GogoColors.gray400,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GogoIcons.speechBubble(
                                      color: GogoColors.gray300),
                                  SizedBox(width: 4),
                                  Text(
                                    post.commentCount.toString(),
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
                                    post.likeCount.toString(),
                                    style: GogoTypography.caption2Semibold
                                        .copyWith(
                                      color: GogoColors.gray300,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                post.createdAt.toString(),
                                style: GogoTypography.caption2Semibold.copyWith(
                                  color: GogoColors.gray500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
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
                      itemCount: post.comment.length,
                      itemBuilder: (BuildContext context, int index) {
                        final comment = post.comment[index];
                        return CommentList(comment);
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
