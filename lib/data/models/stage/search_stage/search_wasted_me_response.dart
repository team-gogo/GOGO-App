import 'package:json_annotation/json_annotation.dart';

part 'search_wasted_me_response.g.dart';

@JsonSerializable()
class SearchWastedMeResponse {
  final bool isWasted;

  SearchWastedMeResponse({
    required this.isWasted,
  });

  factory SearchWastedMeResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchWastedMeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchWastedMeResponseToJson(this);
}
