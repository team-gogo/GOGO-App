import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_ranking_response.g.dart';

@JsonSerializable()
class SearchRankingResponse {
  final Info info;
  final List<Rank> rank;

  SearchRankingResponse({
    required this.info,
    required this.rank,
  });

  factory SearchRankingResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRankingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRankingResponseToJson(this);
}

@JsonSerializable()
class Rank {
  final int rank;
  final int studentId;
  final int point;
  final String name;
  final int classNumber;
  final int studentNumber;

  Rank({
    required this.rank,
    required this.studentId,
    required this.point,
    required this.name,
    required this.classNumber,
    required this.studentNumber,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => _$RankFromJson(json);

  Map<String, dynamic> toJson() => _$RankToJson(this);
}
