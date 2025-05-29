import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/button/gogo_default_button.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import '../../../../design_system/theme/color.dart';
import '../../../../design_system/theme/icon.dart';

class BankruptcyModal extends StatefulWidget {
  BankruptcyModal({super.key,});

  @override
  State<BankruptcyModal> createState() => _BankruptcyModalState();
}

class _BankruptcyModalState extends State<BankruptcyModal> {
  Color checkBoxColor = GogoColors.gray400;
  bool isChecked = false;

  checkingBox() {
    setState(() {
      isChecked = !isChecked;
      checkBoxColor = isChecked ? GogoColors.main500 : GogoColors.gray400;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: GogoColors.gray700,
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 158),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '파산하셨습니다',
              style: GogoTypography.body2Extrabold.copyWith(
                color: GogoColors.white,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      '“The house always wins.”– 불변의 진리\n도박은 언젠가 반드시 패배하게 됩니다. 수많은 선택과 예측 속에서 잠깐의 승리는 달콤했을지 몰라도, 결과는 늘 같습니다.\n당신의 패배는 확률의 귀결이며, 시스템의 당연한 승리입니다.\n\n도박에서 한두 번 이길 수도 있습니다. 하지만 큰 수의 법칙에 따르면 게임이 반복될수록 확률은 원래의 기대값에 수렴합니다.\n즉, 시간이 지날수록 결국 당신은 잃게 되어 있습니다.\n카지노, 베팅 사이트, 심지어 친구들과의 내기까지 모두 수학적으로 설계된 함정입니다.\n\n그리고 도박이 남기는 것은 단순한 패배가 아닙니다. 청소년 도박 중독자는 성인이 되어서도 도박을 끊기 어려우며, 초기의 작은 승리는 더 큰 중독을 불러옵니다.\n결국 빚과 신용 문제, 심지어 범죄로 이어질 수도 있습니다. 도박은 재미일 수 있지만,중독은 현실을 무너뜨립니다.',
                      style: GogoTypography.caption1Semibold
                          .copyWith(color: GogoColors.gray400),
                    ),
                    Text(
                      '\n\nTeam. GOGO는 청소년 불법 도박 근절 캠페인과 함께,  한 번의 기회로 건강한 리셋을 제공합니다.\n\n2층 홈베이스에 비치되어있는 서약서를 작성하고 하고 제출함에 제출하면 한 번의 기회로 포인트를 지원받을 수 있습니다. (전체 포인트의 평균, 최소 3만, 최대 5만)\n그러나 다시는 같은 실수를 반복하지 마세요.\n',
                      style: GogoTypography.caption1Semibold
                          .copyWith(color: GogoColors.white),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              spacing: 18,
              children: [
                GogoDefaultButton(
                  onTap: () => context.pop(),
                  text: '확인',
                ),
                GestureDetector(
                  onTap: checkingBox,
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      spacing: 12,
                      children: [
                        GogoIcons.checkboxOutlined(
                            width: 16, height: 16, color: checkBoxColor),
                        Text(
                          '다시 보지 않기',
                          style: GogoTypography.caption2Semibold
                              .copyWith(color: checkBoxColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
