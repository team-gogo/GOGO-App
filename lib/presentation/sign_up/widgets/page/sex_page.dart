import 'package:flutter/material.dart';
import '../../../../core/design_system/component/button/gogo_default_button.dart';
import '../../../../core/design_system/theme/color.dart';
import '../../../../core/design_system/theme/icon.dart';
import '../../../../core/design_system/theme/typography.dart';

class SexPage extends StatelessWidget {
  const SexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              GogoDefaultButton(onTap: (){}, text: "남성"),
              SizedBox(height: 12,),
              GogoDefaultButton(onTap: (){}, text: "여성"),
              Spacer(),
              GogoDefaultButton(onTap: () {}, text: "다음")
            ],
          ),
        ),
      ),
    );
  }
}
