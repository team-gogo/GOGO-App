import 'package:json_annotation/json_annotation.dart';

part 'amount_dto.g.dart';

@JsonSerializable()
class AmountDTO {
  final int amount;

  AmountDTO({required this.amount});

  factory AmountDTO.fromJson(Map<String, dynamic> json) =>
      _$AmountDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AmountDTOToJson(this);
}
