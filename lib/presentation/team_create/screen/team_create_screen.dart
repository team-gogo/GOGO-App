import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/widget/character_counter_bloc.dart';
import '../bloc/widget/character_counter_event.dart';
import '../bloc/widget/character_counter_state.dart';

import '../../../design_system/component/button/gogo_default_button.dart';

class TeamCreateScreen extends StatefulWidget {
  const TeamCreateScreen({super.key});

  @override
  State<TeamCreateScreen> createState() => _TeamCreateScreen();
}

class _TeamCreateScreen extends State<TeamCreateScreen> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  Widget _editItem(String text, Widget child) => Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GogoTypography.body2Extrabold.copyWith(
              color: GogoColors.white,
            ),
          ),
          child
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterCounterBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: GogoColors.black,
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
                    Text(
                      '경기 이름',
                      style: GogoTypography.body2Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _editItem(
                          '팀 이름',
                          GogoTextField(
                            controller: _teamNameController,
                            hintText: '팀 이름을 입력해주세요',
                            maxLength: 10,
                            onChanged: (text) {
                              context
                                  .read<CharacterCounterBloc>()
                                  .add(TextChanged(text));
                            },
                          ),
                        ),
                        BlocBuilder<CharacterCounterBloc, CharacterCounterState>(
                            builder: (context, state) {
                          return Text(
                            '${state.currentLength}/${state.maxLength}',
                            style: GogoTypography.body3Semibold.copyWith(
                              color: GogoColors.gray500,
                            ),
                          );
                        }),
                      ],
                    ),
                    _editItem(
                        '인원',
                        GogoTextField(
                            controller: _gradeController, hintText: '1학년')),
                    Spacer(),
                    GogoDefaultButton(onTap: () {}, text: '확인')
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
