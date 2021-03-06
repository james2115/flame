import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/animation.dart' as flame_animation;
import 'package:flame/components/animation_component.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Size size = await Flame.util.initialDimensions();
  final game = MyGame(size);
  runApp(game.widget);

  Flame.util.addGestureRecognizer(TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) {
      game.addAnimation();
    });
}

class MyGame extends BaseGame {
  final animation = flame_animation.Animation.sequenced('chopper.png', 4,
      textureWidth: 48, textureHeight: 48, stepTime: 0.15);

  void addAnimation() {
    final animationComponent = AnimationComponent.sequenced(
        291, 178, 'creture.png', 18,
        amountPerRow: 10,
        textureWidth: 291,
        textureHeight: 178,
        stepTime: 0.15,
        loop: false,
        destroyOnFinish: true);
    animationComponent.x = (size.width - 291) / 2;
    animationComponent.y = 250;

    add(animationComponent);
  }

  MyGame(Size screenSize) {
    size = screenSize;

    final animationComponent = AnimationComponent(100, 100, animation);
    animationComponent.x = size.width / 2 - 100;
    animationComponent.y = 100;

    final reversedAnimationComponent =
        AnimationComponent(100, 100, animation.reversed());
    reversedAnimationComponent.x = size.width / 2;
    reversedAnimationComponent.y = 100;

    add(animationComponent);
    add(reversedAnimationComponent);
  }
}
