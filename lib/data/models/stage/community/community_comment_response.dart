import 'package:gogo_app/data/models/stage/community/search_board_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_comment_response.g.dart';

@JsonSerializable()
class CommunityCommentResponse {
  final int commentId;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final Author author;

  CommunityCommentResponse({
    required this.commentId,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.author,
  });

  factory CommunityCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommunityCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityCommentResponseToJson(this);
}
