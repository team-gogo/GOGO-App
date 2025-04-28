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
import '../bloc/write/community_write_event.dart';
import '../bloc/write/community_write_state.dart';

class CommunityWriteScreen extends StatefulWidget {
  const CommunityWriteScreen({
    super.key,
    required this.stageId,
  });

  final int stageId;

  @override
  State<CommunityWriteScreen> createState() => _CommunityWriteScreenState();
}

class _CommunityWriteScreenState extends State<CommunityWriteScreen> {
  final List<String> categoryTexts = [
    '배구',
    '농구',
    '축구',
    '야구',
    '배드민턴',
    '기타'
  ];
  final List<Widget Function({Color color, double height, double width})>
      categoryIcons = [
    GogoIcons.volleyball,
    GogoIcons.basketball,
    GogoIcons.football,
    GogoIcons.baseball,
    GogoIcons.badminton,
    GogoIcons.etc
  ];

  final List<GameType> gameTypes = [
    GameType.VOLLEY_BALL,
    GameType.BASKET_BALL,
    GameType.SOCCER,
    GameType.BASE_BALL,
    GameType.BADMINTON,
    GameType.ETC,
  ];

  GameType? selectedGameType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommunityWriteBloc(
        gameType: gameTypes.first, 
        stageId: widget.stageId
      ),
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
                SizedBox(
                  height: 24,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      categoryTexts.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGameType = gameTypes[index];
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  index == categoryTexts.length - 1 ? 0 : 12),
                          child: GogoTagComponent(
                            tagState: selectedGameType == gameTypes[index],
                            color: GogoColors.main500,
                            text: categoryTexts[index],
                            icon: categoryIcons[index](
                              color: selectedGameType == gameTypes[index]
                                  ? Colors.white
                                  : GogoColors.main500,
                              height: 12,
                              width: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GogoTextField(
                      hintText: '제목을 입력해주세요.',
                      onChanged: (value) => context
                          .read<CommunityWriteBloc>()
                          .add(TitleChanged(value)),
                      controller: TextEditingController(text: state.title)
                        ..selection =
                            TextSelection.collapsed(offset: state.title.length),
                    ),
                    Text('${state.title.length}/30',
                        style: GogoTypography.body3Semibold
                            .copyWith(color: GogoColors.gray500)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GogoTextField(
                      hintText: '내용을 입력해주세요.',
                      onChanged: (value) => context
                          .read<CommunityWriteBloc>()
                          .add(ContentChanged(value)),
                      controller: TextEditingController(text: state.content)
                        ..selection = TextSelection.collapsed(
                            offset: state.content.length),
                    ),
                    Text('${state.content.length}/30',
                        style: GogoTypography.body3Semibold
                            .copyWith(color: GogoColors.gray500)),
                  ],
                ),
                Spacer(),
                GogoDefaultButton(
                  color:
                      state.isValid ? GogoColors.main500 : GogoColors.gray300,
                  onTap: state.isValid ? () {
                    context.read<CommunityWriteBloc>().add(PostWrite(
                      title: state.title, 
                      content: state.content,
                      ));
                      Navigator.pop(context);
                  } : () {
                    print('입력좀 해라'); 
                  },
                  text: '확인하기',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
