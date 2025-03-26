import 'package:json_annotation/json_annotation.dart';
part 'search_my_point_response.g.dart';

@JsonSerializable()
class SearchMyPointResponse {
  final int point;

  SearchMyPointResponse({
    required this.point,
  });

  factory SearchMyPointResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMyPointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMyPointResponseToJson(this);
}
