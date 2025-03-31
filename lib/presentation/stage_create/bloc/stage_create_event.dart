import '../../../data/models/stage/create_stage/api/fast_stage_create_request.dart';

abstract class StageCreateEvent {}

class CreateStageCreate extends StageCreateEvent {
  final FastStageCreateRequest request;

  CreateStageCreate({required this.request});
}
