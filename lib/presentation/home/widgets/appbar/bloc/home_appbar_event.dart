abstract class HomeAppbarEvent {}

class SelectHomeAppbarEvent extends HomeAppbarEvent {
  final int index;

  SelectHomeAppbarEvent({required this.index});
}
