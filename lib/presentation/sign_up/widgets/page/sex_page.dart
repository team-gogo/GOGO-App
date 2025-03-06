import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/sex/sex_bloc.dart';
import '../../../../design_system/component/button/gogo_default_button.dart';
import '../../../../design_system/theme/color.dart';
import '../../../../design_system/theme/icon.dart';
import '../../../../design_system/theme/typography.dart';
import '../../bloc/sex/sex_state.dart';

class SexPage extends StatelessWidget {
  const SexPage({
    super.key,
    required this.onBackClick,
    required this.onNextClick,
  });

  final VoidCallback onBackClick;
  final VoidCallback onNextClick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SexBloc, SexState>(
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
            SizedBox(
              height: 40,
            ),
            Text(
              '반과 번호를 알려주세요',
              style:
                  GogoTypography.title4Extrabold.copyWith(color: GogoColors.white),
            ),
            SizedBox(
              height: 36,
            ),
            GogoDefaultButton(
              onTap: ()=> context.read<SexBloc>().sexController = Sex.male,
              text: "남성",
              color: state is EnableMaleSexState
                  ? GogoColors.main600
                  : GogoColors.gray400,
            ),
            SizedBox(
              height: 12,
            ),
            GogoDefaultButton(
              onTap: ()=>context.read<SexBloc>().sexController = Sex.female,
              text: "여성",
              color: state is EnableFemaleSexState
                  ? GogoColors.main600
                  : GogoColors.gray400,
            ),
            Spacer(),
            GogoDefaultButton(
              onTap: state is EnableSexState ? onNextClick : () {},
              text: "다음",
              color: state is EnableSexState
                  ? GogoColors.main600
                  : GogoColors.gray400,
            ),
          ],
        );
      }
    );
  }
}
