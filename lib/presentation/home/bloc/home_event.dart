abstract class HomeEvent {}

class LoadHome extends HomeEvent {}

class LoadMatchesByDate extends HomeEvent {
  final DateTime selectedDate;

  LoadMatchesByDate(this.selectedDate);
}

class CheckBankruptcy extends HomeEvent {
  final int stageId;
  final bool isBankruptcy;

  CheckBankruptcy(this.stageId, this.isBankruptcy);
}
