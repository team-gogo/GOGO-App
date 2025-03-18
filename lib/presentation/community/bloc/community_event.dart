abstract class CommunityEvent {}

class TitleChanged extends CommunityEvent {
  final String title;
  TitleChanged(this.title);
}

class ContentChanged extends CommunityEvent {
  final String content;
  ContentChanged(this.content);
}
