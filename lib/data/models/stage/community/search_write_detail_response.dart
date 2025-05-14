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
  final String? imageUrl;
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
    required this.imageUrl,
    required this.stage,
    required this.commentCount,
    required this.comment,
  });

  factory SearchCommunityDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCommunityDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCommunityDetailResponseToJson(this);

  SearchCommunityDetailResponse copyWith({
    int? boardId,
    String? title,
    String? content,
    int? likeCount,
    bool? isLiked,
    String? createdAt,
    String? imageUrl,
    Stage? stage,
    int? commentCount,
    List<Comment>? comment,
  }) {
    return SearchCommunityDetailResponse(
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      stage: stage ?? this.stage,
      commentCount: commentCount ?? this.commentCount,
      comment: comment ?? this.comment,
    );
  }
}

@JsonSerializable()
class Comment {
  final int commentId;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isLiked;

  Comment({
    required this.commentId,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isLiked,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    int? commentId,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
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

  Stage copyWith({
    String? name,
    GameType? category,
  }) {
    return Stage(
      name: name ?? this.name,
      category: category ?? this.category,
    );
  }
}
