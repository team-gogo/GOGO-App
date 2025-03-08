import 'package:json_annotation/json_annotation.dart';

part 'additional_sign_up_response.g.dart';

enum Sex { MALE, FEMALE }

enum SchoolType { MiddleSchool, HighSchool }

@JsonSerializable()
class AdditionalSignUpRequest {
  final String? deviceToken;
  final String name;
  final int classNumber;
  final int studentNumber;
  final Sex sex;
  final School school;

  AdditionalSignUpRequest({
    this.deviceToken,
    required this.name,
    required this.classNumber,
    required this.studentNumber,
    required this.sex,
    required this.school,
  });

  factory AdditionalSignUpRequest.fromJson(Map<String, dynamic> json) => _$AdditionalSignUpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalSignUpResponseToJson(this);
}

@JsonSerializable()
class School {
  final String sdCode;
  final String name;
  final SchoolType type;
  final String address;
  final String region;
  final int countOfStudent;
  final String phoneNumber;

  School({
    required this.sdCode,
    required this.name,
    required this.type,
    required this.address,
    required this.region,
    required this.countOfStudent,
    required this.phoneNumber,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
