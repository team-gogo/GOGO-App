import 'package:json_annotation/json_annotation.dart';

part 'community_like_response.g.dart';

@JsonSerializable()
class CommunityLikeResponse {
  final bool isLiked;

  CommunityLikeResponse({required this.isLiked});

  factory CommunityLikeResponse.fromJson(Map<String, dynamic> json) => _$CommunityLikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityLikeResponseToJson(this);
}