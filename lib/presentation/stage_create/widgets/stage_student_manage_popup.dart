import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/auth/student/student_response.dart';
import 'package:gogo_app/design_system/component/text_field/gogo_text_field.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/stage_create/bloc/widget/stage_student_manage_popup_bloc.dart';
import 'package:gogo_app/presentation/stage_create/bloc/widget/stage_student_manage_popup_event.dart';
import 'package:gogo_app/presentation/stage_create/bloc/widget/stage_student_manage_popup_state.dart';
import '../../../design_system/component/button/gogo_default_button.dart';
import '../../../design_system/theme/color.dart';

Future<List<Student>> stageStudentManagePopup(
  BuildContext context,
  List<Student> studentList,
  int minimumTeamSize,
  int maximumTeamSize,
) async {
  final List<Student> result = List.from(studentList);
  final dialogResult = await showDialog<Map<String, dynamic>?>(
    context: context,
    builder: (context) => StageStudentManagePopup(
      studentList: result,
      minimumTeamSize: minimumTeamSize,
      maximumTeamSize: maximumTeamSize,
    ),
  );
  if (dialogResult?['studentList'] != null) {
    return List<Student>.from(dialogResult!['studentList']);
  }
  return result;
}

class StageStudentManagePopup extends StatefulWidget {
  const StageStudentManagePopup(
      {super.key,
      required this.studentList,
      required this.minimumTeamSize,
      required this.maximumTeamSize});

  final List<Student> studentList;
  final int minimumTeamSize;
  final int maximumTeamSize;

  @override
  State<StageStudentManagePopup> createState() =>
      _StageStudentManagePopupState();
}

class _StageStudentManagePopupState extends State<StageStudentManagePopup> {
  late List<Student> selectedStudent;

  @override
  void initState() {
    super.initState();
    selectedStudent = List.from(widget.studentList);
    print(selectedStudent);
  }

  bool get isSelectionChanged {
    if (selectedStudent.length != widget.studentList.length) return true;
    for (final student in selectedStudent) {
      if (!widget.studentList.contains(student)) return true;
    }
    return false;
  }

  void toggleStudent(Student student) {
    setState(() {
      if (selectedStudent.contains(student)) {
        selectedStudent.remove(student);
      } else {
        if (selectedStudent.length >= widget.minimumTeamSize) {
          selectedStudent.removeAt(0); // 가장 먼저 추가된 학생 삭제
        }
        selectedStudent.add(student);
      }
    });
  }

  Widget _buildStudentListItem(Student student) {
    final isSelected = selectedStudent.contains(student);
    return GestureDetector(
      onTap: () => toggleStudent(student),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              spacing: 24,
              mainAxisSize: MainAxisSize.min,
              children: [
                isSelected
                    ? GogoIcons.checkboxFilled(
                        width: 24,
                        height: 24,
                        color: GogoColors.main600,
                      )
                    : GogoIcons.checkboxOutlined(
                        width: 24,
                        height: 24,
                        color: GogoColors.gray500,
                      ),
                Text(
                  "${student.grade}${student.classNumber}${student.studentNumber.toString().padLeft(2, '0')} ${student.name}",
                  style: GogoTypography.body2Semibold.copyWith(
                    color: isSelected ? GogoColors.white : GogoColors.gray400,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: GogoColors.gray600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentList(StageStudentManagePopupState state) {
    if (state is SearchedStageStudentManage &&
        state.searchedStudentResponse.isEmpty) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '검색 결과가 존재하지 않습니다',
          style: GogoTypography.caption2Semibold.copyWith(
            color: GogoColors.gray400,
          ),
        ),
      );
    } else if (state is SearchedStageStudentManage) {
      return Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        children: state.searchedStudentResponse
            .map((student) => _buildStudentListItem(student))
            .toList(),
      );
    }
    return SizedBox();
  }

  Widget _buildClearAllButton() {
    return GestureDetector(
      onTap: () => setState(() => selectedStudent.clear()),
      child: Text(
        '전체 지우기',
        style:
            GogoTypography.caption2Semibold.copyWith(color: GogoColors.gray500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StageStudentManagePopupBloc(),
      child: BlocBuilder<StageStudentManagePopupBloc,
          StageStudentManagePopupState>(
        builder: (context, state) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: GogoColors.gray700,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: GogoColors.gray600),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GogoTextField(
                      controller: context
                          .read<StageStudentManagePopupBloc>()
                          .searchStudentController,
                      hintText: '학생을 입력해주세요',
                      onEditingComplete: () {
                        final text = context
                            .read<StageStudentManagePopupBloc>()
                            .searchStudentController
                            .text;
                        context
                            .read<StageStudentManagePopupBloc>()
                            .add(SearchingStudentEvent(text));
                      },
                      endIcon: GogoIcons.search(
                        color: context
                                .read<StageStudentManagePopupBloc>()
                                .searchStudentController
                                .text
                                .isNotEmpty
                            ? GogoColors.white
                            : GogoColors.gray400,
                      ),
                    ),
                  ),
                  _buildStudentList(state),
                  Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildClearAllButton(),
                      Container(
                          width: 1, height: 20, color: GogoColors.gray600),
                      Row(
                        spacing: 12,
                        children: [
                          Text(
                            '총 개수',
                            style: GogoTypography.caption1Semibold.copyWith(
                              color: GogoColors.gray500,
                            ),
                          ),
                          Text(
                            selectedStudent.length.toString(),
                            style: GogoTypography.caption1Semibold.copyWith(
                              color: GogoColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GogoDefaultButton(
                    onTap: isSelectionChanged
                        ? () => Navigator.pop(
                            context, {'studentList': selectedStudent})
                        : () {},
                    color: isSelectionChanged
                        ? GogoColors.main600
                        : GogoColors.gray400,
                    text: "확인",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
