import 'package:json_annotation/json_annotation.dart';
import '../../common/match_dto.dart';
import '../match_round.dart';

part 'search_match_response.g.dart';

@JsonSerializable()
class SearchMatchResponse {
  final int count;
  final List<MatchDto> match;

  SearchMatchResponse({
    required this.count,
    required this.match,
  });

  factory SearchMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMatchResponseToJson(this);
}
