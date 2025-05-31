class CommunityWriteState {
  final String title;
  final String content;
  final bool isValid;
  final String? imageUrl;

  CommunityWriteState({
    required this.title,
    required this.content,
    required this.isValid,
    this.imageUrl,
  });

  CommunityWriteState copyWith({
    String? title,
    String? content,
    bool? isValid,
    String? imageUrl,
  }) {
    return CommunityWriteState(
      title: title ?? this.title,
      content: content ?? this.content,
      isValid: isValid ?? this.isValid,
      imageUrl: imageUrl,
    );
  }
}

class PostWriteSuccessState extends CommunityWriteState {
  PostWriteSuccessState()
      : super(title: '', content: '', isValid: false, imageUrl: null);
}

class PostWriteErrorState extends CommunityWriteState {
  final String message;

  PostWriteErrorState({required this.message}) : super(title: '', content: '', isValid: false, imageUrl: null);
}