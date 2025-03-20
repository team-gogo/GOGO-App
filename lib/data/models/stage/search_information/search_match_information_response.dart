import 'package:json_annotation/json_annotation.dart';

part 'search_match_information_response.g.dart';

@JsonSerializable()
class SearchMatchInformationResponse {
  final DateTime startDate;
  final DateTime endDate;
  final Stage stage;

  SearchMatchInformationResponse({
    required this.startDate,
    required this.endDate,
    required this.stage,
  });

  factory SearchMatchInformationResponse.fromJson(Map<String, dynamic> json) => _$SearchMatchInformationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMatchInformationResponseToJson(this);
}

@JsonSerializable()
class Stage {
  final List<int> maintainers;
  final List<int> teamA;
  final List<int> teamB;

  Stage({
    required this.maintainers,
    required this.teamA,
    required this.teamB,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);
}
