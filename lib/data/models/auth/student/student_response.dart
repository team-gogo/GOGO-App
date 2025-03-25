import 'package:json_annotation/json_annotation.dart';
import '../additional_sign_up/additional_sign_up_response.dart';

part 'student_response.g.dart';

@JsonSerializable()
class Student {
  final int studentId;
  final int grade;
  final int studentNumber;
  final int classNumber;
  final String name;

  const Student({
    required this.studentId,
    required this.grade,
    required this.studentNumber,
    required this.classNumber,
    required this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
