import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum StageType {
  @JsonValue("FAST")
  FAST,
  @JsonValue("OFFICIAL")
  OFFICIAL,
}
