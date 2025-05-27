import 'package:gogo_app/data/models/stage/search_information/search_game_format_response.dart';

abstract class MatchTeamBracketState {
  const MatchTeamBracketState();
}

class InitMatchTeamBracket extends MatchTeamBracketState {
  const InitMatchTeamBracket();
}

class LoadingMatchTeamBracket extends MatchTeamBracketState {
  const LoadingMatchTeamBracket();
}

class LoadedMatchTeamBracket extends MatchTeamBracketState {
  final SearchGameFormatResponse gameFormatResponse;

  const LoadedMatchTeamBracket({
    required this.gameFormatResponse,
  });
}

class ErrorMatchTeamBracket extends MatchTeamBracketState {
  final String errorMessage;

  const ErrorMatchTeamBracket({
    required this.errorMessage,
  });
}
