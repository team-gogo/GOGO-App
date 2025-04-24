import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_write_detail_response.g.dart';

@JsonSerializable()
class SearchCommunityDetailResponse {
  final int boardId;
  final String title;
  final String content;
  final int likeCount;
  final bool isLiked;
  final String createdAt;
  final Stage stage;
  final int commentCount;
  final List<Comment> comment;

  SearchCommunityDetailResponse({
    required this.boardId,
    required this.title,
    required this.content,
    required this.likeCount,
    required this.isLiked,
    required this.createdAt,
    required this.stage,
    required this.commentCount,
    required this.comment,
  });

  factory SearchCommunityDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCommunityDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCommunityDetailResponseToJson(this);
}

@JsonSerializable()
class Comment {
  final int commentId;
  final String comment;
  final DateTime createdAt;
  final int likeCount;
  final bool isLiked;

  Comment({
    required this.commentId,
    required this.comment,
    required this.createdAt,
    required this.likeCount,
    required this.isLiked,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class Stage {
  final String name;
  final GameType category;

  Stage({
    required this.name,
    required this.category,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);

  Map<String, dynamic> toJson() => _$StageToJson(this);
}
