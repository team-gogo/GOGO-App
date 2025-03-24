import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/router.dart';
import '../../../design_system/component/stage/gogo_stage_card_component.dart';
import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/icon.dart';
import '../../../design_system/theme/typography.dart';
import '../widget/gogo_profile_card_component.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool selected = false;

  final TextStyle subjectStyle = GogoTypography.body3Semibold.copyWith(
    color: GogoColors.gray500,
  );

  final TextStyle mainStyle = GogoTypography.caption1Extrabold.copyWith(
    color: GogoColors.white,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selected = false;
      }),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '내 정보',
                      style: GogoTypography.body2Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    ProfileCardComponent(
                      name: '박유현',
                      school: '광주소프트웨어마이스터그동학교',
                      male: '남자',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      '내가 참여한 스테이지',
                      style: GogoTypography.body2Extrabold
                          .copyWith(color: GogoColors.white),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Column(
                      spacing: 22,
                      children: List.generate(
                        10,
                        (index) => GogoStageCardComponent(
                          stageName: '스테이지 이름',
                          official: true,
                          recruiting: true,
                          manager: false,
                          broadcast: true,
                          onTap: () {},
                          buttonText: '상세보기',
                          buttonIcon: GogoIcons.lock(),
                          color: GogoColors.gray700,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        selected = !selected;
                      }),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            GogoIcons.gearWheel(
                              width: 24,
                              height: 24,
                              color: selected
                                  ? GogoColors.white
                                  : GogoColors.gray500,
                            ),
                            Text(
                              '설정',
                              style: selected
                                  ? subjectStyle.copyWith(
                                      color: GogoColors.white)
                                  : subjectStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (selected)
                      Container(
                        padding: EdgeInsets.all(24),
                        width: 108,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000),
                              blurRadius: 9,
                            ),
                          ],
                          color: GogoColors.gray700,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          spacing: 36,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  context.pushNamed(PageRouter.editProfile),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  '정보수정',
                                  style: GogoTypography.body3Semibold.copyWith(
                                    color: GogoColors.white,
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                alignment: Alignment.center,
                                child: Text(
                                  '회원 탈퇴',
                                  style: GogoTypography.body3Semibold.copyWith(
                                    color: GogoColors.error,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SizedBox.shrink()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
