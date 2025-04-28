abstract class CommunityWriteEvent {}

class TitleChanged extends CommunityWriteEvent {
  final String title;
  TitleChanged(this.title);
}

class ContentChanged extends CommunityWriteEvent {
  final String content;
  ContentChanged(this.content);
}

class PostWrite extends CommunityWriteEvent {
  final String title;
  final String content;

  PostWrite({required this.title, required this.content});
}