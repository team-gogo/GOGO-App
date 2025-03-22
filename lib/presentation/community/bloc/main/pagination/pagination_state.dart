abstract class PaginationState {}

class PaginationInitial extends PaginationState {}

class PaginationChanged extends PaginationState {
  final int page;

  PaginationChanged({required this.page});
}
