import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';

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
