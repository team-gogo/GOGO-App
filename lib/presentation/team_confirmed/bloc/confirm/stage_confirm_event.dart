import 'package:gogo_app/data/models/stage/handle_stage/team_apply_request.dart';

import '../../../../data/models/stage/handle_stage/stage_confirm_request.dart';

abstract class StageConfirmEvent {
  const StageConfirmEvent();
}

class PostStageConfirmEvent extends StageConfirmEvent {
  final int stageId;
  final StateConfirmRequest stateConfirmRequest;

  const PostStageConfirmEvent(
    this.stageId, {
    required this.stateConfirmRequest,
  });
}
