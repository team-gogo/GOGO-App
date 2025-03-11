import 'package:json_annotation/json_annotation.dart';

part 'ticket_counts_response.g.dart';

@JsonSerializable()
class TicketCountsResponse {
  final int plinko;
  final int yavarwee;
  final int coinToss;

  TicketCountsResponse({
    required this.plinko,
    required this.yavarwee,
    required this.coinToss,
  });

  factory TicketCountsResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketCountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketCountsResponseToJson(this);
}
