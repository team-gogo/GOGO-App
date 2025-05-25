import 'package:flutter/cupertino.dart';

abstract class MatchTeamBracketEvent {
  const MatchTeamBracketEvent();
}

class GetMatchTeamBracket extends MatchTeamBracketEvent {
  final int gameId;

  const GetMatchTeamBracket({
    required this.gameId,
  });
}
