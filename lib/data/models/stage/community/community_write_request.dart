import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_write_request.g.dart';

@JsonSerializable()
class CommunityWriteRequest {
  final String title;
  final String content;
  final GameType gameCategory;

  CommunityWriteRequest({
    required this.title,
    required this.content,
    required this.gameCategory,
  });

  factory CommunityWriteRequest.fromJson(Map<String, dynamic> json) =>
      _$CommunityWriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityWriteRequestToJson(this);
}
