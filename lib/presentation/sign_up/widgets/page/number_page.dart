import 'package:flutter/material.dart';
import '../../../../core/design_system/component/button/gogo_default_button.dart';
import '../../../../core/design_system/component/textField/gogo_text_field.dart';
import '../../../../core/design_system/theme/color.dart';
import '../../../../core/design_system/theme/icon.dart';
import '../../../../core/design_system/theme/typography.dart';


class NumberPage extends StatelessWidget {
  const NumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, 93),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GogoIcons.chevronLeft(
                  color: GogoColors.white,
                  width: 40,
                  height: 40,
                  onTap: () {},
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
                  controller: TextEditingController(),
                  hintText: "학년",
                ),
                SizedBox(
                  height: 12,
                ),
                GogoTextField(
                  textFieldState: GogoTextFieldState.basic,
                  controller: TextEditingController(),
                  hintText: "반",
                ),
                SizedBox(
                  height: 12,
                ),
                GogoTextField(
                  textFieldState: GogoTextFieldState.basic,
                  controller: TextEditingController(),
                  hintText: "번호",
                ),
                Spacer(),
                GogoDefaultButton(onTap: () {}, text: "다음")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
