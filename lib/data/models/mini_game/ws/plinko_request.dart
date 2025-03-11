import 'package:json_annotation/json_annotation.dart';

part 'plinko_request.g.dart';

enum RiskLevel { LOW, MEDIUM, HIGH }

@JsonSerializable()
class PlinkoRequest {
  final int amount;
  final RiskLevel risk;

  PlinkoRequest({
    required this.amount,
    required this.risk,
  });

  factory PlinkoRequest.fromJson(Map<String, dynamic> json) =>
      _$PlinkoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlinkoRequestToJson(this);
}
