import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_state.dart';
import '../../../../design_system/component/button/gogo_default_button.dart';
import '../../../../design_system/component/text_field/gogo_text_field.dart';
import '../../../../design_system/theme/color.dart';
import '../../../../design_system/theme/icon.dart';
import '../../../../design_system/theme/typography.dart';

class SchoolPage extends StatelessWidget {
  const SchoolPage({
    super.key,
    required this.onBackClick,
    required this.onNextClick,
  });

  final VoidCallback onBackClick;
  final VoidCallback onNextClick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolBloc, SchoolState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GogoIcons.chevronLeft(
              color: GogoColors.white,
              width: 40,
              height: 40,
              onTap: onBackClick),
          SizedBox(height: 40),
          Text(
            "학교를 알려주세요.",
            style: GogoTypography.title3Extrabold
                .copyWith(color: GogoColors.white),
          ),
          SizedBox(
            height: 36,
          ),
          GogoTextField(
            textFieldState: GogoTextFieldState.search,
            controller: context.read<SchoolBloc>().schoolController,
            hintText: "학교를 입력해주세요.",
          ),
          Spacer(),
          GogoDefaultButton(
            onTap: state is EnableSchoolState ? onNextClick : () {},
            text: "다음",
            color: state is EnableSchoolState
                ? GogoColors.main600
                : GogoColors.gray400,
          ),
        ],
      );
    });
  }
}
