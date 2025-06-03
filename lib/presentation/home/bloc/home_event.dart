abstract class HomeEvent {}

class LoadHome extends HomeEvent {}

class LoadMatchesByDate extends HomeEvent {
  final DateTime selectedDate;

  LoadMatchesByDate(this.selectedDate);
}

class CheckBankruptcy extends HomeEvent {
  final bool isBankruptcy;

  CheckBankruptcy( this.isBankruptcy);
}

class GetMinigameBetLimit extends HomeEvent {
  final int stageId;

  GetMinigameBetLimit({required this.stageId});
}
