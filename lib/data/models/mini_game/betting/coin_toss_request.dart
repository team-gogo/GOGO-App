import 'package:json_annotation/json_annotation.dart';import '../../../../presentation/cointoss/bloc/coin_toss_event.dart';

part 'coin_toss_request.g.dart';

enum CoinTossStatus { FRONT, BACK }

@JsonSerializable()
class CoinTossRequest {
  final int amount; // 배팅할 돈
  final CoinTossStatus bet;

  CoinTossRequest({
    required this.amount,
    required this.bet,
  });

  factory CoinTossRequest.fromJson(Map<String, dynamic> json) =>
      _$CoinTossRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTossRequestToJson(this);
}
