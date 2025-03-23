import 'package:gogo_app/data/models/stage/community/sort_type.dart';
import 'package:gogo_app/data/models/stage/game_type.dart';

abstract class CommunityWriteEvent {}

class TitleChanged extends CommunityWriteEvent {
  final String title;
  TitleChanged(this.title);
}

class ContentChanged extends CommunityWriteEvent {
  final String content;
  ContentChanged(this.content);
}
