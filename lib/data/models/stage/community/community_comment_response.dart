import 'package:json_annotation/json_annotation.dart';

part 'community_comment_response.g.dart';

@JsonSerializable()
class CommunityCommentResponse {
  final int commentId;
  final String content;
  final DateTime createdAt;
  final int likeCount;

  CommunityCommentResponse({
    required this.commentId,
    required this.content,
    required this.createdAt,
    required this.likeCount,
  });

  factory CommunityCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommunityCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityCommentResponseToJson(this);
}
