import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class DoneAnimation extends StatelessWidget {
  final AnimationController _controller;
  final bool _animate;

  DoneAnimation(this._controller, this._animate);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Lottie.asset(
        'assets/lottie_files/28702-done.json',
        width: 60,
        height: 60,
        controller: _controller,
        onLoaded: (composition) {
          if (_animate) {
            _controller
              ..duration = composition.duration
              ..forward().then((value) {
                _controller
                  ..reset()
                  ..value = 1;
              });
          } else {
            _controller.value = 1; // static displayed image of animation
          }
        },
      ),
    );
  }
}
