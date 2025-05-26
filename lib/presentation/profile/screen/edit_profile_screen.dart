import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_event.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile__bloc.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile_event.dart';
import 'package:gogo_app/presentation/profile/bloc/profile_edit/edit_profile_state.dart';
import 'package:gogo_app/presentation/profile/bloc/profile/profile_bloc.dart';

import '../../../design_system/component/button/gogo_default_button.dart';

class EditProfilePage extends StatefulWidget {
  final UserInfoResponse userInfo;

  const EditProfilePage({super.key, required this.userInfo});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Sex _currentSex = Sex.MALE;

  @override
  void initState() {
    super.initState();
    _currentSex = widget.userInfo.sex;
  }

  Widget _editItem(String text, Widget child) => Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GogoTypography.body2Extrabold.copyWith(
              color: GogoColors.white,
            ),
          ),
          child
        ],
      );

  bool profanityFilter = false;

  Widget _buildFilterToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '비속어 필터',
          style: GogoTypography.body2Extrabold.copyWith(
            color: profanityFilter ? GogoColors.error : GogoColors.gray500,
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => profanityFilter = !profanityFilter),
          child: GogoIcons.checkboxOutlined(
            width: 36,
            height: 36,
            color: profanityFilter ? GogoColors.error : GogoColors.gray500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
      create: (_) => EditProfileBloc(
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        widget.userInfo.sex,
        widget.userInfo
      ),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            context.pop(true);
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: GogoColors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 17, 16, 60),
              child: Column(
                spacing: 36,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    GogoTopBar(
                    title: '정보수정',
                    onBackTap: () => context.pop(),
                  ),
                  _editItem(
                      '이름',
                      GogoTextField(
                          controller: context.read<EditProfileBloc>().nameController, 
                          hintText: widget.userInfo.name,
                          validator: context.read<EditProfileBloc>().nameValidator,
                          keyboardType: TextInputType.text,
                          inputFormatter: [
                            FilteringTextInputFormatter(RegExp('[a-zA-Z가-힣]'), allow: true),
                          ],
                          ),),
                  _editItem(
                      '학년',
                     GogoTextField(
                controller: context.read<EditProfileBloc>().gradeController,
                hintText: '${widget.userInfo.grade}학년',
                validator: context.read<EditProfileBloc>().gradeValidator,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter(RegExp('[1-6]'), allow: true),
                  LengthLimitingTextInputFormatter(1),
                  GradeSuffixInputFormatter(),
                ],
              ),
                  ),
                  _editItem(
                      '반',
                      GogoTextField(
                controller: context.read<EditProfileBloc>().classController,
                hintText: '${widget.userInfo.classNumber}반',
                validator: context.read<EditProfileBloc>().classValidator,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
                  LengthLimitingTextInputFormatter(2),
                  ClassSuffixInputFormatter()
                ],
                ),
                  ),
                  _editItem(
                      '번호',
                      GogoTextField(
                controller: context.read<EditProfileBloc>().numberController,
                hintText: '${widget.userInfo.studentNumber}번',
                validator: context.read<EditProfileBloc>().numberValidator,
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
                  LengthLimitingTextInputFormatter(2),
                  NumberSuffixInputFormatter()
                ],
              ),),
                  _editItem(
                    '성별',
                    Column(
                      spacing: 12,
                      children: [
                        GogoDefaultButton(
                          onTap: () {
                            setState(() {
                              _currentSex = Sex.MALE;
                            });
                            context.read<EditProfileBloc>().add(UpdateSexEvent(sex: Sex.MALE));
                          },
                          text: "남성", 
                          textColor: _currentSex == Sex.MALE
                              ? GogoColors.white
                              : GogoColors.gray400,
                          color: _currentSex == Sex.MALE
                              ? GogoColors.main500
                              : GogoColors.gray700,
                        ),
                        GogoDefaultButton(
                          onTap: () {
                            setState(() {
                              _currentSex = Sex.FEMALE;
                            });
                            context.read<EditProfileBloc>().add(UpdateSexEvent(sex: Sex.FEMALE));
                          },
                          text: "여성",
                          textColor: _currentSex == Sex.FEMALE
                              ? GogoColors.white
                              : GogoColors.gray400,
                          color: _currentSex == Sex.FEMALE
                              ? GogoColors.main500
                              : GogoColors.gray700,
                        ),
                      ],
                    ),
                  ),
                  _buildFilterToggle(),
                 GogoDefaultButton(
                onTap: () => state is EnableUserInfoState
                    ? {
                        context.read<EditProfileBloc>().add(UpdateProfileEvent(isFiltered: profanityFilter)),
                      }
                    : () {},
                text: "확인",
                color: state is EnableUserInfoState
                    ? GogoColors.main600
                    : GogoColors.gray400,
                 ),
                ]
              ),
              ),
            ),
        ),
      ),
    );
  }
}
