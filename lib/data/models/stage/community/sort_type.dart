import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum SortType {
  @JsonValue("LAST")
  LAST,
  @JsonValue("LATEST")
  LATEST,
}
