import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/stage/search_stage/search_stage_response.dart';
import 'package:gogo_app/design_system/component/stage/gogo_stage_card_component.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/presentation/loading/screens/loadaing_page.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_event.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_state.dart';
import 'package:gogo_app/router.dart';

import '../../../design_system/theme/color.dart';
import '../../../design_system/theme/typography.dart';
import '../widget/profile_card_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) => ProfileBloc()..add(FetchMyProfile()),
      child: ProfileContentScreen(),
    );
  }
}

class ProfileContentScreen extends StatefulWidget {
  const ProfileContentScreen({super.key});

  @override
  State<ProfileContentScreen> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContentScreen> {
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
      child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) {
        return previous != current;
      }, builder: (context, state) {
        if (state is ProfileLoadingState) {
          return LoadingPage();
        } else if (state is ProfileLoadedState) {
          List<Stage> participatedStages = [];
          List<Stage> recruitingStage = [];
          List<Stage> confirmedStages = [];
          for (int i = 0; i < state.searchStageResponse.count; i++) {
            if (state.searchStageResponse.stages[i].isParticipating) {
              participatedStages.add(state.searchStageResponse.stages[i]);
            }
            if (state.searchStageResponse.stages[i].status ==
                StageStatus.CONFIRMED) {
              confirmedStages.add(state.searchStageResponse.stages[i]);
            }
            if (state.searchStageResponse.stages[i].status ==
                StageStatus.RECRUITING) {
              recruitingStage.add(state.searchStageResponse.stages[i]);
            }
          }

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 24,
                    children: [
                      GogoTopBar(
                          title: '뒤로가기', onBackTap: () => context.pop(context)),
                      Stack(
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
                                name: state.userInfoResponse.name,
                                school: state.userInfoResponse.schoolName,
                                male: state.userInfoResponse.sex == Sex.MALE
                                    ? "남자"
                                    : "여자",
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
                                  participatedStages.length,
                                  (index) => GogoStageCardComponent(
                                    stage: participatedStages[index],
                                    color: GogoColors.gray700,
                                    broadcast: false,
                                  ),
                                ),
                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    spacing: 15,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final result =
                                              await context.pushNamed(
                                            PageRouter.editProfile,
                                            extra: state.userInfoResponse,
                                          );
                                          if (result == true) {
                                            context
                                                .read<ProfileBloc>()
                                                .add(FetchMyProfile());
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '정보수정',
                                            style: GogoTypography.body3Semibold
                                                .copyWith(
                                              color: GogoColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProfileBloc>()
                                              .add(LogoutProfile());
                                          context.goNamed(
                                            PageRouter.login,
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '로그아웃',
                                            style: GogoTypography.body3Semibold
                                                .copyWith(
                                              color: GogoColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProfileBloc>()
                                              .add(WithdrawProfile());
                                          context.goNamed(
                                            PageRouter.login,
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '회원 탈퇴',
                                            style: GogoTypography.body3Semibold
                                                .copyWith(
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
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is ProfileErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
