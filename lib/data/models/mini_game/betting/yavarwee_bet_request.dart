import 'package:json_annotation/json_annotation.dart';

part 'yavarwee_bet_request.g.dart';

@JsonSerializable()
class YavarweeBetRequest {
  final int amount;

  YavarweeBetRequest({
    required this.amount,
  });

  factory YavarweeBetRequest.fromJson(Map<String, dynamic> json) => _$YavarweeBetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$YavarweeBetRequestToJson(this);
} 