import 'package:gogo_app/data/models/stage/enum_type/game_type.dart';

import '../../../data/models/betting/request/betting_match_request.dart';

abstract class MatchListEvent {}

class LoadItems extends MatchListEvent {
  final GameType? gameType;
  final SortOrder? sortOrder;

  LoadItems({this.gameType, this.sortOrder});
}

enum SortOrder { ascending, descending }

class BettingMatch extends MatchListEvent {
  final int matchId;
  final BettingMatchRequest request;

  BettingMatch({
    required this.matchId,
    required this.request,
  });
}
