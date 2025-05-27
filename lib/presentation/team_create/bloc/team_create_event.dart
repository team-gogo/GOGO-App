import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';

abstract class TeamCreateEvent {
  const TeamCreateEvent();
}

class PostTeamCreateEvent extends TeamCreateEvent {
  final TeamApplyRequest teamApplyRequest;
  final int gameId;

  const PostTeamCreateEvent(
    this.gameId, {
    required this.teamApplyRequest,
  });
}
