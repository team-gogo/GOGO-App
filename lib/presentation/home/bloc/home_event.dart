abstract class HomeEvent {}

class LoadHome extends HomeEvent {}

class LoadMatchesByDate extends HomeEvent {
  final DateTime selectedDate;

  LoadMatchesByDate(this.selectedDate);
}
