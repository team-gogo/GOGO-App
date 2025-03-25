import 'package:json_annotation/json_annotation.dart';

part 'coin_toss_response.g.dart';

@JsonSerializable()
class CoinTossResponse {
  final bool result;
  final int amount;

  CoinTossResponse({
    required this.result,
    required this.amount,
  });

  factory CoinTossResponse.fromJson(Map<String, dynamic> json) =>
      _$CoinTossResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTossResponseToJson(this);
}
