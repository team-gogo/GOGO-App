abstract class PageIndicatorEvent {}

class PageChangedEvent extends PageIndicatorEvent {
  final int index;
  PageChangedEvent(this.index);
}
