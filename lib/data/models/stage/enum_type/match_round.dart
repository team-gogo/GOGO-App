import 'package:json_annotation/json_annotation.dart';

enum MatchRound {
  @JsonValue("ROUND_OF_32")
  ROUND_OF_32,
  @JsonValue("ROUND_OF_16")
  ROUND_OF_16,
  @JsonValue("QUARTER_FINALS")
  QUARTER_FINALS,
  @JsonValue("SEMI_FINALS")
  SEMI_FINALS,
  @JsonValue("FINALS")
  FINALS,
}
