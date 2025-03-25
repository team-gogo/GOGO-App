import 'package:json_annotation/json_annotation.dart';

part 'community_comment_request.g.dart';

@JsonSerializable()
class CommunityCommentRequest {
  final String content;

  CommunityCommentRequest({required this.content});

  factory CommunityCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$CommunityCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityCommentRequestToJson(this);
}
