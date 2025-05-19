import 'package:json_annotation/json_annotation.dart';

part 'active_game_response.g.dart';

@JsonSerializable()
class ActiveGameResponse {
  final bool isPlinkoActive;
  final bool isCoinTossActive;
  final bool isYavarweeActive;

  const ActiveGameResponse({
    required this.isPlinkoActive,
    required this.isCoinTossActive,
    required this.isYavarweeActive,
  });

  factory ActiveGameResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveGameResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveGameResponseToJson(this);
}
