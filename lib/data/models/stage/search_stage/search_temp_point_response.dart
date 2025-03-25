import 'package:json_annotation/json_annotation.dart';
part 'search_temp_point_response.g.dart';

@JsonSerializable()
class SearchTempPointResponse {
  final int tempPointId;
  final int tempPoint;
  final DateTime expiredDate;

  SearchTempPointResponse({
    required this.tempPointId,
    required this.tempPoint,
    required this.expiredDate,
  });

  factory SearchTempPointResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTempPointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTempPointResponseToJson(this);
}
