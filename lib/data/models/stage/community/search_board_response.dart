import 'package:json_annotation/json_annotation.dart';

import '../game_type.dart';
import '../stage_type.dart';

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
  final GameType gameType;
  final String title;
  final int likeCount;
  final DateTime createdAt;
  final bool isFiltered;
  final StageType stageType;
  final Author author;

  Board({
    required this.boardId,
    required this.gameType,
    required this.title,
    required this.likeCount,
    required this.createdAt,
    required this.isFiltered,
    required this.stageType,
    required this.author,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson() => _$BoardToJson(this);
}

@JsonSerializable()
class Author {
  final int studentId;
  final String name;
  final int classNumber;
  final int studentNumber;

  Author({
    required this.studentId,
    required this.name,
    required this.classNumber,
    required this.studentNumber,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
