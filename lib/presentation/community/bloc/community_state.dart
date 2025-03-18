class CommunityState {
  final String title;
  final String content;
  final bool isValid;

  CommunityState({
    required this.title,
    required this.content,
    required this.isValid,
  });

  CommunityState copyWith({
    String? title,
    String? content,
    bool? isValid,
  }) {
    return CommunityState(
      title: title ?? this.title,
      content: content ?? this.content,
      isValid: isValid ?? this.isValid,
    );
  }
}
