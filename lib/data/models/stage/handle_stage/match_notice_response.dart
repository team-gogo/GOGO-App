import 'package:json_annotation/json_annotation.dart';
part 'match_notice_response.g.dart';

@JsonSerializable()
class MatchNoticeResponse {
  final bool isNotice;

  MatchNoticeResponse({required this.isNotice});

  factory MatchNoticeResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchNoticeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MatchNoticeResponseToJson(this);
}
