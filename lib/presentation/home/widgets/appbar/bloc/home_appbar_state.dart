abstract class HomeAppbarState {}

class InitHomeAppbarState extends HomeAppbarState {}

class SelectHomeAppbarState extends HomeAppbarState {
  int index;

  SelectHomeAppbarState({required this.index});
}
