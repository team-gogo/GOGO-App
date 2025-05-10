abstract class CharacterCounterEvent {}

class TextChanged extends CharacterCounterEvent {
  final String text;

  TextChanged(this.text);
}
