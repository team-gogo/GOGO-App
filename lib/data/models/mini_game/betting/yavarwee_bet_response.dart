import 'package:json_annotation/json_annotation.dart';

part 'yavarwee_bet_response.g.dart';

@JsonSerializable()
class YavarweeBetResponse {
  final String uuid;

  YavarweeBetResponse({
    required this.uuid,
  });

  factory YavarweeBetResponse.fromJson(Map<String, dynamic> json) => _$YavarweeBetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YavarweeBetResponseToJson(this);
} 