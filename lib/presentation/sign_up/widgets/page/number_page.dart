import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/number/number_state.dart';
import '../../../../core/design_system/component/button/gogo_default_button.dart';
import '../../../../core/design_system/component/text_field/gogo_text_field.dart';
import '../../../../core/design_system/theme/color.dart';
import '../../../../core/design_system/theme/icon.dart';
import '../../../../core/design_system/theme/typography.dart';
import '../../bloc/number/number_bloc.dart';


class NumberPage extends StatelessWidget {
  const NumberPage({
    super.key,
    required this.onBackClick,
    required this.onNextClick,
  });

  final VoidCallback onBackClick;
  final VoidCallback onNextClick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberBloc, NumberState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GogoIcons.chevronLeft(
            color: GogoColors.white,
            width: 40,
            height: 40,
            onTap: onBackClick,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '반과 번호를 알려주세요',
            style: GogoTypography.title4Extrabold
                .copyWith(color: GogoColors.white),
          ),
          SizedBox(
            height: 36,
          ),
          GogoTextField(
            textFieldState: GogoTextFieldState.basic,
            controller: context.read<NumberBloc>().gradeController,
            hintText: "학년",
            validator: context.read<NumberBloc>().gradeValidator,
            keyboardType: TextInputType.number,
            inputFormatter: [
              FilteringTextInputFormatter(RegExp('[1-6]'), allow: true),
              LengthLimitingTextInputFormatter(1),
              GradeSuffixInputFormatter(),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GogoTextField(
            textFieldState: GogoTextFieldState.basic,
            controller: context.read<NumberBloc>().classController,
            hintText: "반",
            validator: context.read<NumberBloc>().classValidator,
            keyboardType: TextInputType.number,
            inputFormatter: [
              FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
              LengthLimitingTextInputFormatter(2),
              ClassSuffixInputFormatter()
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GogoTextField(
            textFieldState: GogoTextFieldState.basic,
            controller: context.read<NumberBloc>().numberController,
            hintText: "번호",
            validator: context.read<NumberBloc>().numberValidator,
            keyboardType: TextInputType.number,
            inputFormatter: [
              FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
              LengthLimitingTextInputFormatter(2),
              NumberSuffixInputFormatter()
            ],
          ),
          Spacer(),
          GogoDefaultButton(
            onTap: state is EnableNumberState ? onNextClick : () {},
            text: "다음",
            color: state is EnableNumberState
                ? GogoColors.main600
                : GogoColors.gray400,
          ),
        ],
      );
    });
  }
}
