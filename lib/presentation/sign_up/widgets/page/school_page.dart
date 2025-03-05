import 'package:flutter/material.dart';
import '../../../../core/design_system/component/button/gogo_default_button.dart';
import '../../../../core/design_system/component/textfield/gogo_text_field.dart';
import '../../../../core/design_system/theme/color.dart';
import '../../../../core/design_system/theme/icon.dart';
import '../../../../core/design_system/theme/typography.dart';

class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 95),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GogoIcons.chevronLeft(
                  color: GogoColors.white,
                  width: 40,
                  height: 40,
                  onTap: () {},
                ),
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
                  controller: TextEditingController(),
                  hintText: "학교를 입력해주세요.",
                ),
                Spacer(),
                GogoDefaultButton(
                    onTap: () {}, text: "다음")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
