import 'package:flutter/material.dart';

import '../../../../core/design_system/component/button/gogo_default_button.dart';
import '../../../../core/design_system/component/textfield/gogo_text_field.dart';
import '../../../../core/design_system/theme/color.dart';
import '../../../../core/design_system/theme/icon.dart';
import '../../../../core/design_system/theme/typography.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GogoColors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 95),
        child: Column(
          children: [
            GogoIcons.chevronLeft(),
            SizedBox(height: 40),
            Text(
              "이름을 알려주세요.",
              style: GogoTypography.title3Extrabold,
            ),
            GogoTextField(
                textFieldState: GogoTextFieldState.search,
                controller: TextEditingController(),
                hintText: "이름를 입력해주세요.",
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: GogoColors.gray700,
              textStyle: GogoTypography.body3Semibold,
              hintStyle: GogoTypography.body3Semibold,
            ),
            Spacer(),
            GogoDefaultButton(
                onTap: (){},
                text: "다음"
            )
          ],
        ),
      ),
    );
  }
}