import 'package:json_annotation/json_annotation.dart';

part 'community_write_request.g.dart';

@JsonSerializable()
class CommunityWriteRequest {
  final String title;
  final String content;

  CommunityWriteRequest({
    required this.title,
    required this.content,
  });

  factory CommunityWriteRequest.fromJson(Map<String, dynamic> json) =>
      _$CommunityWriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityWriteRequestToJson(this);
}
