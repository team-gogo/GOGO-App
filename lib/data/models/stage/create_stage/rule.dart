import 'package:json_annotation/json_annotation.dart';

part 'rule.g.dart';

@JsonSerializable()
class Rule {
  final int maxBettingPoint;
  final int minBettingPoint;

  Rule({required this.maxBettingPoint, required this.minBettingPoint});

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  Map<String, dynamic> toJson() => _$RuleToJson(this);
}
