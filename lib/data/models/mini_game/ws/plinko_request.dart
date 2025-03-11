import 'package:json_annotation/json_annotation.dart';

part 'plinko_request.g.dart';

@JsonSerializable()
class PlinkoRequest {
  final String proof;
  final String uuid;
  final int amount;
  final int round;

  PlinkoRequest({
    required this.proof,
    required this.uuid,
    required this.amount,
    required this.round,
  });

  factory PlinkoRequest.fromJson(Map<String, dynamic> json) =>
      _$PlinkoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlinkoRequestToJson(this);
}
