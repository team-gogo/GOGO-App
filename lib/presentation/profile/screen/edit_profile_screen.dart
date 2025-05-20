import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

import '../../../design_system/component/button/gogo_default_button.dart';

class EditProfilePage extends StatefulWidget {

  final UserInfoResponse userInfo;


  EditProfilePage({super.key,required this.userInfo});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _gradeController = TextEditingController();

  final TextEditingController _classController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();

  Sex _sexController = Sex.FEMALE;

  bool profanityFilter = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GogoColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 17, 16, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 36,
              children: [
                GogoTopBar(
                  title: '정보수정',
                  onBackTap: () => context.pop(context),
                ),
                _editItem(
                    '이름',
                    GogoTextField(
                        controller: _nameController, hintText: widget.userInfo.name)),
                _editItem(
                    '학년',
                    GogoTextField(
                        controller: _gradeController, hintText: widget.userInfo.grade.toString())),
                _editItem(
                    '반',
                    GogoTextField(
                        controller: _classController, hintText: widget.userInfo.classNumber.toString())),
                _editItem(
                    '번호',
                    GogoTextField(
                        controller: _numberController, hintText: widget.userInfo.studentNumber.toString())),
                _editItem(
                  '성별',
                  Column(
                    spacing: 12,
                    children: [
                      GogoDefaultButton(
                        onTap: () => setState(() {
                          _sexController = Sex.MALE;
                        }),
                        text: "남성",
                        textColor: _sexController == Sex.MALE
                            ? GogoColors.white
                            : GogoColors.gray400,
                        color: _sexController == Sex.MALE
                            ? GogoColors.main500
                            : GogoColors.gray700,
                      ),
                      GogoDefaultButton(
                        onTap: () => setState(() {
                          _sexController = Sex.FEMALE;
                        }),
                        text: "여성",
                        textColor: _sexController == Sex.FEMALE
                            ? GogoColors.white
                            : GogoColors.gray400,
                        color: _sexController == Sex.FEMALE
                            ? GogoColors.main500
                            : GogoColors.gray700,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '비속어 필터',
                      style: GogoTypography.body2Extrabold.copyWith(
                        color: profanityFilter
                            ? GogoColors.error
                            : GogoColors.gray500,
                      ),
                    ),
                    GestureDetector (
                      onTap: () => setState(() {
                        profanityFilter = !profanityFilter;
                      }),
                      child: profanityFilter
                          ? GogoIcons.checkboxOutlined(
                              width: 36,
                              height: 36,
                              color: GogoColors.error,
                            )
                          : GogoIcons.checkboxOutlined(
                              width: 36,
                              height: 36,
                              color: GogoColors.gray500,
                            ),
                    )
                  ],
                ),
                GogoDefaultButton(onTap: () {}, text: '확인')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
