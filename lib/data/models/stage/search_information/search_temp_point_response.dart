import 'package:json_annotation/json_annotation.dart';

part 'search_temp_point_response.g.dart';

@JsonSerializable()
class SearchTempPointResponse {
  final List<TempPoint> tempPoints;

  SearchTempPointResponse({required this.tempPoints});

  factory SearchTempPointResponse.fromJson(Map<String, dynamic> json) =>
    _$SearchTempPointResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchTempPointResponseToJson(this);
}

@JsonSerializable()
class TempPoint {
  final int tempPointId;
  final int temPoint;
  final String expiredDate;

  TempPoint({
    required this.tempPointId,
    required this.temPoint,
    required this.expiredDate
  });

  factory TempPoint.fromJson(Map<String, dynamic> json) =>
    _$TempPointFromJson(json);
  Map<String, dynamic> toJson() => _$TempPointToJson(this);
}