import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';

abstract class CommunityWriteEvent {}

class TitleChanged extends CommunityWriteEvent {
  final String title;
  TitleChanged(this.title);
}

class ContentChanged extends CommunityWriteEvent {
  final String content;
  ContentChanged(this.content);
}

class ImageChanged extends CommunityWriteEvent {
  final String? imageUrl;
  ImageChanged(this.imageUrl);
}

class PostWrite extends CommunityWriteEvent {
  final String title;
  final String content;
  final GameType gameType;

  PostWrite({required this.title, required this.content,required this.gameType});
}
