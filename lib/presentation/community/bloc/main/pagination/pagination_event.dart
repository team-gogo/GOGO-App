abstract class PaginationEvent {}

class ChangePageEvent extends PaginationEvent {
  final int page;

  ChangePageEvent({required this.page});
}
