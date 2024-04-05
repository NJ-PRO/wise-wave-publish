import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimProps>();

    // Add opacity track
   tween.add(AnimProps.opacity, Tween(begin: 0.0, end: 1.0));

    // Add translation track
    tween.add(AnimProps.translateY, Tween(begin: -30.0, end: 0.0));

    return PlayAnimation<MultiTweenValues<AnimProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: const Duration(milliseconds: 500),
      tween: tween,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AnimProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AnimProps.translateY)),
            child: child),
      ),
      curve: Curves.easeOut,
      child: child,
    );
  }
}