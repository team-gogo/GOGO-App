abstract class CommunityDetailEvent {}

class FetchCommunityDetailEvent extends CommunityDetailEvent {}

class CommunityCommentLiked extends CommunityDetailEvent {
  final int commentId;

  CommunityCommentLiked({required this.commentId});
}
