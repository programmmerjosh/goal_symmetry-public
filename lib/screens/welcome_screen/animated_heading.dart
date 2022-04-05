import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import '../../custom_styles/custom_text_styles.dart';

class AnimatedHeading extends StatelessWidget {
  const AnimatedHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Goal Symmetry',
            speed: const Duration(milliseconds: 150),

            // totalRepeatCount: 4,
            // repeatForever: false,
            // text: [],
            textStyle: Theme.of(context).backgroundColor == Colors.black
                ? ktsGoalTypeItem.copyWith(fontSize: 30)
                : ktsGoalTypeItem.copyWith(fontSize: 30, color: Colors.black),
          )
        ],
      ),
    );
  }
}
