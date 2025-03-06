import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/name/name_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/name/name_state.dart';
import '../../../../design_system/component/button/gogo_default_button.dart';
import '../../../../design_system/component/text_field/gogo_text_field.dart';
import '../../../../design_system/theme/color.dart';
import '../../../../design_system/theme/icon.dart';
import '../../../../design_system/theme/typography.dart';

class NamePage extends StatelessWidget {
  final VoidCallback onBackClick;
  final VoidCallback onNextClick;

  const NamePage({
    super.key,
    required this.onBackClick,
    required this.onNextClick,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameBloc, NameState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GogoIcons.chevronLeft(
              color: GogoColors.white,
              width: 40,
              height: 40,
              onTap: onBackClick,
            ),
            SizedBox(height: 40),
            Text(
              "이름을 알려주세요.",
              style:
                  GogoTypography.title3Extrabold.copyWith(color: GogoColors.white),
            ),
            SizedBox(
              height: 36,
            ),
            GogoTextField(
              textFieldState: GogoTextFieldState.basic,
              controller: context.read<NameBloc>().nameController,
              hintText: "이름를 입력해주세요.",
              validator: context.read<NameBloc>().validateName,
            ),
            Spacer(),
            GogoDefaultButton(
              onTap: state is EnableNameState ? onNextClick : () {},
              text: "다음",
              color: state is EnableNameState
                  ? GogoColors.main600
                  : GogoColors.gray400,
            ),
          ],
        );
      }
    );
  }
}
