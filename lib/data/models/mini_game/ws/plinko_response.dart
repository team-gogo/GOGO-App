import 'package:json_annotation/json_annotation.dart';

part 'plinko_response.g.dart';

@JsonSerializable()
class PlinkoResponse {
  final int amount;
  final List<String> path;

  PlinkoResponse({required this.amount, required this.path});

  factory PlinkoResponse.fromJson(Map<String, dynamic> json) => _$PlinkoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlinkoResponseToJson(this);
}
