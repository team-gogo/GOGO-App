abstract class CommunityDetailEvent {}

class FetchCommunityDetailEvent extends CommunityDetailEvent {}

class CommunityCommentLiked extends CommunityDetailEvent {
  final int commentId;

  CommunityCommentLiked({required this.commentId});
}

class CommunityWriteComment extends CommunityDetailEvent {
  final String content;

  CommunityWriteComment({required this.content});
}