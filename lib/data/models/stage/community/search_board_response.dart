import 'package:json_annotation/json_annotation.dart';

import '../enum_type/game_type.dart';
import '../enum_type/stage_type.dart';

part 'search_board_response.g.dart';

@JsonSerializable()
class SearchBoardResponse {
  final Info info;
  final List<Board> board;

  SearchBoardResponse({
    required this.info,
    required this.board,
  });

  factory SearchBoardResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchBoardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchBoardResponseToJson(this);
}

@JsonSerializable()
class Info {
  final int totalPage;
  final int totalElement;

  Info({
    required this.totalPage,
    required this.totalElement,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Board {
  final int boardId;
  final GameType gameCategory;
  final String title;
  final int likeCount;
  final DateTime createdAt;
  final StageType stageType;
  final int commentCount;

  Board({
    required this.boardId,
    required this.gameCategory,
    required this.title,
    required this.likeCount,
    required this.createdAt,
    required this.commentCount,
    required this.stageType,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson() => _$BoardToJson(this);
}
