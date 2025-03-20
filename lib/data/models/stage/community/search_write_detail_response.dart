import 'package:gogo_app/data/models/stage/game_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_write_detail_response.g.dart';

@JsonSerializable()
class SearchWriteDetailResponse {
  final int boardId;
  final String title;
  final String content;
  final int likeCount;
  final bool isLiked;
  final String createdAt;
  final Stage stage;
  final Author Authorauthor;
  final int commentCount;
  final List<Comment> comment;

  SearchWriteDetailResponse({
    required this.boardId,
    required this.title,
    required this.content,
    required this.likeCount,
    required this.isLiked,
    required this.createdAt,
    required this.stage,
    required this.Authorauthor,
    required this.commentCount,
    required this.comment,
  });

  factory SearchWriteDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchWriteDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchWriteDetailResponseToJson(this);
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

@JsonSerializable()
class Comment {
  final int commentId;
  final String comment;
  final String createdAt;
  final bool isFiltered;
  final Author author;

  Comment({
    required this.commentId,
    required this.comment,
    required this.createdAt,
    required this.isFiltered,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class Stage {
  final String name;
  final GameType GameCategory;

  Stage({
    required this.name,
    required this.GameCategory,
  });

  factory Stage.fromJson(Map<String, dynamic> json) =>
      _$StageFromJson(json);

  Map<String, dynamic> toJson() => _$StageToJson(this);
}
