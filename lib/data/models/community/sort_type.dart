import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum StageType {
  @JsonValue("LASTEST")
  LASTEST,
  @JsonValue("OLDEST")
  OLDEST,
}
