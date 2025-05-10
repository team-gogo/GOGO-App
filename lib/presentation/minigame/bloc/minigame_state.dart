abstract class MinigameDescriptionState {}

class MinigameDescriptionInitial extends MinigameDescriptionState {}

class MinigameDescriptionUpdated extends MinigameDescriptionState {
  final String minigameName;

  MinigameDescriptionUpdated({required this.minigameName});
}
