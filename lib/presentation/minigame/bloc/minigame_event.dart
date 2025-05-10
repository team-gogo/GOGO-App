abstract class MinigameDescriptionEvent {}

class ChangeCategory extends MinigameDescriptionEvent {
  final String minigameName;

  ChangeCategory({required this.minigameName});
}
