import 'package:json_annotation/json_annotation.dart';

part 'additional_sign_up_response.g.dart';

enum Sex { MALE, FEMALE }

enum SchoolType { MIDDLE_SCHOOL, HIGH_SCHOOL }

@JsonSerializable()
class AdditionalSignUpRequest {
  final String? deviceToken;
  final String name;
  final int grade;
  final int classNumber;
  final int studentNumber;
  final Sex sex;
  final School school;

  AdditionalSignUpRequest({
    this.deviceToken,
    required this.name,
    required this.grade,
    required this.classNumber,
    required this.studentNumber,
    required this.sex,
    required this.school,
  });

  factory AdditionalSignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$AdditionalSignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalSignUpRequestToJson(this);
}

@JsonSerializable()
class School {
  final String sdCode;
  final String name;
  final SchoolType type;
  final String address;
  final String region;
  final String phoneNumber;

  School({
    required this.sdCode,
    required this.name,
    required this.type,
    required this.address,
    required this.region,
    required this.phoneNumber,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      sdCode: json['SD_SCHUL_CODE'] as String? ?? '',
      name: json['SCHUL_NM'] as String? ?? '',
      type: _mapSchoolType(json['SCHUL_KND_SC_NM'] as String?),
      address: '${json['ORG_RDNMA'] ?? ''} ${json['ORG_RDNDA'] ?? ''}'.trim(),
      region: json['LCTN_SC_NM'] as String? ?? '',
      phoneNumber: json['ORG_TELNO'] as String? ?? '',
    );
  }

  static SchoolType _mapSchoolType(String? type) {
    if (type == null) {
      throw ArgumentError('학교 유형이 null입니다.');
    }
    if (type.contains('중학교')) {
      return SchoolType.MIDDLE_SCHOOL;
    }
    if (type.contains('고등학교')) {
      return SchoolType.HIGH_SCHOOL;
    } else {
      throw ArgumentError('알 수 없는 학교 유형: $type');
    }
  }

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
