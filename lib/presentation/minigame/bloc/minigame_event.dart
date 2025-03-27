abstract class MinigameDescriptionEvent {}

class ChangeCategory extends MinigameDescriptionEvent {
  final int selectedIndex;

  ChangeCategory({required this.selectedIndex});
}
