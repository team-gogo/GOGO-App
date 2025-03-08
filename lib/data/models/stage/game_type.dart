import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum GameType {
  @JsonValue("SOCCER")
  SOCCER,
  @JsonValue("BASKET_BALL")
  BASKET_BALL,
  @JsonValue("BASE_BALL")
  BASE_BALL,
  @JsonValue("VOLLEY_BALL")
  VOLLEY_BALL,
  @JsonValue("BADMINTON")
  BADMINTON,
  @JsonValue("LOL")
  LOL,
  @JsonValue("ETC")
  ETC,
}
