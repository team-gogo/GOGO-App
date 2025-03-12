import 'package:json_annotation/json_annotation.dart';

part 'yavarwee_request.g.dart';

@JsonSerializable()
class YavarweeRequest {
  final String proof;
  final String uuid;
  final int amount;
  final int round;

  YavarweeRequest({
    required this.proof,
    required this.uuid,
    required this.amount,
    required this.round,
  });

  factory YavarweeRequest.fromJson(Map<String, dynamic> json) => _$YavarweeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$YavarweeRequestToJson(this);
}
