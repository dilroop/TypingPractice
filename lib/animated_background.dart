import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  final BoxConstraints constraints;

  AnimatedBackground(this.constraints, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 6), ColorTween(begin: Colors.green.shade600, end: Colors.red.shade600)),
      Track("color2").add(Duration(seconds: 6), ColorTween(begin: Colors.orange, end: Colors.lightBlue.shade800))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          constraints: this.constraints,
          child: this.child,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}
