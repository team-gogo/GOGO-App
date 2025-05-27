import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/bloc/write/community_write_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/write/community_write_event.dart';
import '../bloc/write/community_write_state.dart';

class CommunityWriteScreen extends StatefulWidget {
  const CommunityWriteScreen({
    super.key,
    required this.stageId, required this.gameTypeList,
  });

  final int stageId;
  final List<GameType> gameTypeList;

  final String titleHintText = '내용을 입력해주세요.';

  @override
  State<CommunityWriteScreen> createState() => _CommunityWriteScreenState();
}

class _CommunityWriteScreenState extends State<CommunityWriteScreen> {
  static categoryTexts(GameType gameType) {
    switch (gameType) {
      case GameType.VOLLEY_BALL:
        return '배구';
      case GameType.BASKET_BALL:
        return '농구';
      case GameType.SOCCER:
        return '축구';
      case GameType.BASE_BALL:
        return '야구';
      case GameType.LOL:
        return 'LOL';
      case GameType.BADMINTON:
        return '배드민턴';
      default:
        return '기타';
    }
  }

  static categoryIcons(GameType gameType) {
    switch (gameType) {
      case GameType.VOLLEY_BALL:
        return GogoIcons.volleyball;
      case GameType.BASKET_BALL:
        return GogoIcons.basketball;
      case GameType.SOCCER:
        return GogoIcons.football;
      case GameType.BASE_BALL:
        return GogoIcons.baseball;
      case GameType.LOL:
        return GogoIcons.eSports;
      case GameType.BADMINTON:
        return GogoIcons.badminton;
      default:
        return GogoIcons.etc;
    }
  }

  GameType? selectedGameType;

  @override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context) => CommunityWriteBloc(stageId: widget.stageId),
    child: BlocListener<CommunityWriteBloc, CommunityWriteState>(
      listener: (context, state) {
        if (state is PostWriteSuccessState) {
          Navigator.pop(context, true);
        } else if (state is PostWriteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<CommunityWriteBloc, CommunityWriteState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              minimum: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GogoTopBar(
                    title: '커뮤니티 생성하기',
                    onBackTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        widget.gameTypeList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGameType = widget.gameTypeList[index];
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index == widget.gameTypeList.length - 1 ? 0 : 12,
                            ),
                            child: GogoTagComponent(
                              tagState: selectedGameType == widget.gameTypeList[index],
                              color: GogoColors.main500,
                              text: categoryTexts(widget.gameTypeList[index]),
                              icon: categoryIcons(widget.gameTypeList[index])(
                                color: selectedGameType == widget.gameTypeList[index]
                                    ? Colors.white
                                    : GogoColors.main500,
                                height: 12.0,
                                width: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (state.imageUrl == null) {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  context.read<CommunityWriteBloc>().add(ImageChanged(image.path));
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: GogoColors.gray700,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '이미지 등록',
                                        style: GogoTypography.body3Semibold.copyWith(
                                          color: GogoColors.gray400,
                                        ),
                                      ),
                                      SizedBox(width: 9),
                                      if (state.imageUrl != null)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: GogoColors.gray500,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            '1',
                                            style: GogoTypography.caption2Semibold.copyWith(
                                              color: GogoColors.gray300,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (state.imageUrl == null)
                                    GogoIcons.plusCircle(
                                      color: GogoColors.gray400,
                                      width: 20,
                                      height: 20,
                                    )
                                  else
                                    GestureDetector(
                                      onTap: () {
                                        context.read<CommunityWriteBloc>().add(ImageChanged(null));
                                      },
                                      child: GogoIcons.trash(
                                        color: GogoColors.gray400,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              GogoIcons.exclamationMarkCircle(
                                color: GogoColors.gray500,
                                width: 16,
                                height: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '이미지 등록시 1개만 가능합니다.',
                                style: GogoTypography.caption2Semibold.copyWith(
                                  color: GogoColors.gray500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      GogoTextField(
                        hintText: '제목을 입력해주세요.',
                        onChanged: (value) => context
                            .read<CommunityWriteBloc>()
                            .add(TitleChanged(value)),
                        controller: TextEditingController(text: state.title)
                          ..selection = TextSelection.collapsed(offset: state.title.length),
                      ),
                      Text(
                        '${state.title.length}/30',
                        style: GogoTypography.body3Semibold.copyWith(color: GogoColors.gray500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GogoTextField(
                        hintText: widget.titleHintText,
                        onChanged: (value) => context
                            .read<CommunityWriteBloc>()
                            .add(ContentChanged(value)),
                        controller: TextEditingController(text: state.content)
                          ..selection = TextSelection.collapsed(offset: state.content.length),
                      ),
                      Text(
                        '${state.content.length}/30',
                        style: GogoTypography.body3Semibold.copyWith(color: GogoColors.gray500),
                      ),
                    ],
                  ),
                  Spacer(),
                  GogoDefaultButton(
                    color: state.isValid && selectedGameType != null
                        ? GogoColors.main500
                        : GogoColors.gray300,
                    onTap: state.isValid && selectedGameType != null
                        ? () {
                            context.read<CommunityWriteBloc>().add(PostWrite(
                                  title: state.title,
                                  content: state.content,
                                  gameType: selectedGameType!,
                                ));
                            setState(() {
                              selectedGameType = null;
                            });
                          }
                        : () {},
                    text: '확인하기',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
}
