import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_state.dart';
import 'package:gogo_app/presentation/sign_up/widgets/page/school/school_search_component.dart';
import 'package:gogo_app/router.dart';
import '../../../../design_system/component/button/gogo_default_button.dart';
import '../../../../design_system/component/text_field/gogo_text_field.dart';
import '../../../../design_system/theme/color.dart';
import '../../../../design_system/theme/icon.dart';
import '../../../../design_system/theme/typography.dart';

class SchoolPage extends StatelessWidget {
  final PageController pageController;

  const SchoolPage({
    super.key,
    required this.pageController,
  });

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
              onTap: () => context.goNamed(PageRouter.login)),
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
            onEditingComplete: () => context.read<SchoolBloc>().add(
                EnterSchoolEvent(
                    context.read<SchoolBloc>().schoolController.text)),
            controller: context.read<SchoolBloc>().schoolController,
            hintText: "학교를 입력해주세요.",
            endIcon: GogoIcons.search(),
          ),
          SizedBox(
            height: 12,
          ),
          state is InitSchoolState || state is ChooseSchoolState
              ? SizedBox()
              : SchoolSearchComponent(),
          Spacer(),
          GogoDefaultButton(
            onTap: state is ChooseSchoolState
                ? () => pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    )
                : () {},
            text: "다음",
            color: state is ChooseSchoolState
                ? GogoColors.main600
                : GogoColors.gray400,
          ),
        ],
      );
    });
  }
}
