import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/stage/community/search_write_detail_response.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_bloc.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_event.dart';
import 'package:gogo_app/presentation/community/bloc/detail/community_detail_state.dart';
import 'package:gogo_app/presentation/loadaing_page.dart';

class CommunityDetailScreen extends StatelessWidget {
  final int boardId;

  CommunityDetailScreen({
    required this.boardId,
    super.key,
  });

  Map<GameType, Widget> gameTypeIcons = {
    GameType.SOCCER: GogoIcons.football(color: GogoColors.main500, height: 16, width: 16),
    GameType.BASKET_BALL: GogoIcons.basketball(color: GogoColors.main500, height: 16, width: 16),
    GameType.BASE_BALL: GogoIcons.baseball(color: GogoColors.main500, height: 16, width: 16),
    GameType.VOLLEY_BALL: GogoIcons.volleyball(color: GogoColors.main500, height: 16, width: 16),
    GameType.BADMINTON: GogoIcons.badminton(color: GogoColors.main500, height: 16, width: 16),
    GameType.LOL: GogoIcons.eSports(color: GogoColors.main500, height: 16, width: 16),
    GameType.ETC: GogoIcons.etc(color: GogoColors.main500, height: 16, width: 16),
  };

  Map<GameType, String> gameTypeTexts = {
    GameType.SOCCER: "축구",
    GameType.BASKET_BALL: "농구",
    GameType.BASE_BALL: "야구",
    GameType.VOLLEY_BALL: "배구",
    GameType.BADMINTON: "배드민턴",
    GameType.LOL: "롤",
    GameType.ETC: "기타",
  };

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return BlocProvider<CommunityDetailBloc>(
      create: (BuildContext context) =>
          CommunityDetailBloc(boardId: boardId)..add(FetchCommunityDetailEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          minimum: EdgeInsets.all(14),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<CommunityDetailBloc, CommunityDetailState>(
                    buildWhen: (previous, current) {
                      return previous != current;
                    },
                    builder: (context, state) {
                      switch (state) {
                        case CommunityDetailLoadingState _:
                          return SizedBox();

                        case CommunityDetailLoadedState _:
                          return Column(
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
                                          text: gameTypeTexts[state.response.stage.category]!,
                                          icon: gameTypeIcons[state.response.stage.category],
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          state.response.stage.name,
                                          style: GogoTypography.caption2Extrabold.copyWith(
                                            color: GogoColors.gray300,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Row(
                                          children: [
                                            GogoIcons.person(color: GogoColors.gray300),
                                            SizedBox(width: 4),
                                            Text(
                                              "익명",
                                              style: GogoTypography.caption2Semibold.copyWith(
                                                color: GogoColors.gray300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18),
                                    Text(
                                      state.response.title,
                                      style: GogoTypography.caption1Extrabold.copyWith(
                                        color: GogoColors.white,
                                      ),
                                    ),
                                    Text(
                                      state.response.content,
                                      style: GogoTypography.caption2Semibold.copyWith(
                                        color: GogoColors.gray400,
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GogoIcons.speechBubble(color: GogoColors.gray300),
                                            SizedBox(width: 4),
                                            Text(
                                              state.response.commentCount.toString(),
                                              style: GogoTypography.caption2Semibold.copyWith(
                                                color: GogoColors.gray300,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            state.response.isLiked ?
                                            GogoIcons.heartFilled(
                                              onTap: () {
                                                context.read<CommunityDetailBloc>().add(CommunityPostLiked());
                                              },
                                              color: Colors.red,
                                            ) :
                                            GogoIcons.heartOutlined(
                                              onTap: () {
                                                context.read<CommunityDetailBloc>().add(CommunityPostLiked());
                                              },
                                              color:GogoColors.gray300,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              state.response.likeCount.toString(),
                                              style: GogoTypography.caption2Semibold.copyWith(
                                                color: GogoColors.gray300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          DateTime.parse(state.response.createdAt).toIso8601String().substring(0, 10),
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
                                itemCount: state.response.comment.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final comment = state.response.comment[index];
                                  return CommentList(comment: comment);
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 12);
                                },
                              ),
                            ],
                          );

                        case CommunityDetailErrorState _:
                          return Center(
                            child: Text(state.message, style: TextStyle(color: Colors.white)),
                          );

                        default:
                          return const Center(child: Text('No data available'));
                      }
                    },
                  ),
                ),
              ),
              BlocBuilder<CommunityDetailBloc, CommunityDetailState>(
                builder: (context,state) {
                return GogoTextField(
                  keyboardType: TextInputType.multiline,
                  controller: controller,
                  hintText: '댓글을 입력해주세요',
                  endIcon: GogoIcons.send(
                  color: GogoColors.gray400,
                  onTap: () {
                    if (controller.value.text.isNotEmpty) {
                      context.read<CommunityDetailBloc>().add(CommunityWriteComment(content: controller.value.text));
                      controller.clear();
                    }
                  },
                ),
              );
                }
            ),
          ],
        ),
      ),
    ),
  );
}
}

class CommentList extends StatelessWidget {
  final Comment comment;

  const CommentList({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLiked = comment.isLiked ?? false;
    final int likeCount = comment.likeCount;

    void onLikeTap() {
      context.read<CommunityDetailBloc>().add(
        CommunityCommentLiked(commentId: comment.commentId)
      );
    }

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
                "익명",
                style: GogoTypography.caption1Semibold.copyWith(
                  color: GogoColors.gray300,
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                width: 150,
                child: Text(
                  comment.content,
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
              isLiked
                  ? GogoIcons.heartFilled(
                      onTap: onLikeTap,
                      color: Colors.red,
                      width: 20,
                      height: 20,
                    )
                  : GogoIcons.heartOutlined(
                      onTap: onLikeTap,
                      color: GogoColors.gray300,
                      width: 20,
                      height: 20,
                    ),
              SizedBox(width: 4),
              Text(
                likeCount.toString(),
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
}