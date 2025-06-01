import '../../../data/models/stage/handle_stage/join_stage_request.dart';

class StageEvent {}

class GetStageEvent extends StageEvent {}

class EnterStageEvent extends StageEvent {
  final int stageId;
  final JoinStageRequest body;

  EnterStageEvent({required this.stageId, required this.body});
}
