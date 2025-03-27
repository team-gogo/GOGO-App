abstract class MinigameDescriptionState {}

class MinigameDescriptionInitial extends MinigameDescriptionState {}

class MinigameDescriptionUpdated extends MinigameDescriptionState {
  final int selectedIndex;

  MinigameDescriptionUpdated({required this.selectedIndex});
}
