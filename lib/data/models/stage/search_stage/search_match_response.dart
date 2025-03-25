import 'package:json_annotation/json_annotation.dart';
import '../../common/match_dto.dart';
import '../enum_type/match_round.dart';

part 'search_match_response.g.dart';

@JsonSerializable()
class SearchMatchResponse {
  final int count;
  final List<MatchDto> matches;

  SearchMatchResponse({
    required this.count,
    required this.matches,
  });

  factory SearchMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMatchResponseToJson(this);
}
