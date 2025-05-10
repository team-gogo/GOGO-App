import 'package:json_annotation/json_annotation.dart';

part 'search_maintainer_response.g.dart';

@JsonSerializable()

class SearchMaintainerResponse {
  final bool isMaintainer;

  SearchMaintainerResponse({required this.isMaintainer});

  factory SearchMaintainerResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMaintainerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMaintainerResponseToJson(this);
}