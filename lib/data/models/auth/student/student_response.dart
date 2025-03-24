import 'package:json_annotation/json_annotation.dart';
import '../additional_sign_up/additional_sign_up_response.dart';

part 'student_response.g.dart';

@JsonSerializable()
class Student {
  final int userId;
  final int studentId;
  final int schoolId;
  final String email;
  final String name;
  final String? deviceToken;
  final Sex sex;
  final int grade;
  final int classNumber;
  final int studentNumber;
  final bool isActiveProfanityFilter;
  final DateTime createdAt;

  const Student(
      {required this.userId,
      required this.studentId,
      required this.schoolId,
      required this.email,
      required this.name,
      this.deviceToken,
      required this.sex,
      required this.grade,
      required this.classNumber,
      required this.studentNumber,
      required this.isActiveProfanityFilter,
      required this.createdAt});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
