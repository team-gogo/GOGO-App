abstract class MinigameDescriptionEvent {}

class ChangeCategory extends MinigameDescriptionEvent {
  final String minigameName;

  ChangeCategory({required this.minigameName});
}

abstract class MinigameEvent {}

class FetchMinigameInfo extends MinigameEvent {
  final int stageId;

  FetchMinigameInfo({required this.stageId});
}
