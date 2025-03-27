import 'package:json_annotation/json_annotation.dart';
import '../additional_sign_up/additional_sign_up_response.dart';

part 'user_info_request.g.dart';

@JsonSerializable()
class UserInfoRequest {
  final String name;
  final Sex sex;
  final int grade;
  final int classNumber;
  final int studentNumber;
  final bool isFiltered;

  UserInfoRequest({
    required this.name,
    required this.sex,
    required this.grade,
    required this.classNumber,
    required this.studentNumber,
    required this.isFiltered,
  });

  factory UserInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$UserInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoRequestToJson(this);
}
