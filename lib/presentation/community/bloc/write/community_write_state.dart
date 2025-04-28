class CommunityWriteState {
  final String title;
  final String content;
  final bool isValid;

  CommunityWriteState({
    required this.title,
    required this.content,
    required this.isValid,
  });

  CommunityWriteState copyWith({
    String? title,
    String? content,
    bool? isValid,
  }) {
    return CommunityWriteState(
      title: title ?? this.title,
      content: content ?? this.content,
      isValid: isValid ?? this.isValid,
    );
  }
}

class PostWriteErrorState extends CommunityWriteState {
  final String message;

  PostWriteErrorState({required this.message}) : super(title: '', content: '', isValid: false);
}