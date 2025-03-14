import 'package:flame_forge2d/flame_forge2d.dart';

class Ball extends BodyComponent {
  final Vector2 position;

  Ball(this.position);

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 5;
    final fixtureDef = FixtureDef(shape, density: 1, restitution: 0.9);
    final bodyDef = BodyDef(position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
