import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_response.g.dart';

@JsonSerializable()
class UserInfoResponse {
  final int studentId;
  final String name;
  final int schoolId;
  final int grade;
  final String schoolName;
  final int classNumber;
  final int studentNumber;
  final Sex sex;
  final bool isFiltered;

  UserInfoResponse({
    required this.studentId,
    required this.name,
    required this.schoolId,
    required this.grade,
    required this.schoolName,
    required this.classNumber,
    required this.studentNumber,
    required this.sex,
    required this.isFiltered,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
