import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/community/bloc/community.bloc.dart';
import 'package:gogo_app/presentation/community/bloc/community_event.dart';
import 'package:gogo_app/presentation/community/bloc/community_state.dart';

class CommunityWriteScreen extends StatefulWidget {
  CommunityWriteScreen({
    super.key,
  });

  @override
  State<CommunityWriteScreen> createState() => _ComunityWriteScreenState();
}

class _ComunityWriteScreenState extends State<CommunityWriteScreen> {
  static const int max_length = 30;

  final List<String> categoryTexts = [
    '배구',
    '농구',
    '축구',
    '야구',
    'LoL',
    '배드민턴',
    '기타'
  ];
  final List<Widget Function({Color color, double height, double width})>
      categoryIcons = [
    GogoIcons.volleyball,
    GogoIcons.basketball,
    GogoIcons.football,
    GogoIcons.baseball,
    GogoIcons.eSports,
    GogoIcons.badminton,
    GogoIcons.etc
  ];

  final List<GameType> gameTypes = [
    GameType.VOLLEY_BALL,
    GameType.BASKET_BALL,
    GameType.SOCCER,
    GameType.BASE_BALL,
    GameType.LOL,
    GameType.BADMINTON,
    GameType.ETC,
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CommunityBloc()),
        BlocProvider(create: (_) => CommunitySortFilterBloc()),
        BlocProvider(create: (_) => CommunitySportFilterBloc()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          minimum: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
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
              BlocBuilder<CommunitySportFilterBloc, CommunitySportFilterState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 4,
                      children: List.generate(
                        categoryTexts.length,
                        (index) => GestureDetector(
                          onTap: () =>
                              context.read<CommunitySportFilterBloc>().add(
                                    SelectCommunitySportFilterEvent(
                                        gameType: gameTypes[index]),
                                  ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right:
                                    index == categoryTexts.length - 1 ? 0 : 12),
                            child: GogoTagComponent(
                              tagState:
                                  state is SelectedCommunitySportFilterState &&
                                          state.gameType == gameTypes[index]
                                      ? true
                                      : false,
                              color: GogoColors.main500,
                              text: categoryTexts[index],
                              icon: categoryIcons[index](
                                color:
                                    state is SelectedCommunitySportFilterState &&
                                            state.gameType == gameTypes[index]
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
                  );
                },
              ),
              SizedBox(
                height: 12,
              ),
              BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GogoTextField(
                        hintText: '제목을 입력해주세요.',
                        onChanged: (value) => context
                            .read<CommunityBloc>()
                            .add(TitleChanged(value)),
                        controller: TextEditingController(text: state.title)
                          ..selection = TextSelection.collapsed(
                              offset: state.title.length),
                      ),
                      Text('${state.title.length}/30',
                          style: GogoTypography.body3Semibold
                              .copyWith(color: GogoColors.gray500)),
                    ],
                  );
                },
              ),
              BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GogoTextField(
                        hintText: '내용을 입력해주세요.',
                        onChanged: (value) => context
                            .read<CommunityBloc>()
                            .add(ContentChanged(value)),
                        controller: TextEditingController(text: state.content)
                          ..selection = TextSelection.collapsed(
                              offset: state.content.length),
                      ),
                      Text('${state.content.length}/30',
                          style: GogoTypography.body3Semibold
                              .copyWith(color: GogoColors.gray500)),
                    ],
                  );
                },
              ),
              Spacer(),
              BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  return GogoDefaultButton(
                    color:
                        state.isValid ? GogoColors.main500 : GogoColors.gray300,
                    onTap: state.isValid ? () {} : () {},
                    text: '확인하기',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<SportTag> sportTags = [
  SportTag(
      text: '배구',
      icon: GogoIcons.volleyball(
          color: GogoColors.main500, width: 12, height: 12)),
  SportTag(
      text: '농구',
      icon: GogoIcons.basketball(
          color: GogoColors.main500, width: 12, height: 12)),
  SportTag(
      text: '축구',
      icon:
          GogoIcons.football(color: GogoColors.main500, width: 12, height: 12)),
  SportTag(
      text: '야구',
      icon:
          GogoIcons.baseball(color: GogoColors.main500, width: 12, height: 12)),
  SportTag(
      text: 'LOL',
      icon:
          GogoIcons.eSports(color: GogoColors.main500, width: 12, height: 12)),
  SportTag(
      text: '배드민턴',
      icon: GogoIcons.badminton(
          color: GogoColors.main500, width: 12, height: 12)),
  SportTag(
      text: '기타',
      icon: GogoIcons.etc(color: GogoColors.main500, width: 12, height: 12)),
];

class SportTag {
  final String text;
  final Widget icon;

  SportTag({required this.text, required this.icon});
}
