import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../custom_styles/custom_text_styles.dart';

TutorialCoachMark buildTutorial(
    BuildContext context, List<TargetFocus> targets, List<Key> keys,
    {Function onFinish, Function onTargetPressed, Function onSkip}) {
  if (keys != null && targets != null) {
    if (keys.length == targets.length) {
      return TutorialCoachMark(
        context,
        targets: targets, // List<TargetFocus>

        // colorShadow: Colors.red, // DEFAULT Colors.black
        // colorShadow: Color.fromRGBO(12, 12, 12, 0.1),
        opacityShadow: 0.7,
        // alignSkip: Alignment.bottomRight,

        textSkip: "CANCEL",
        // textSkip: "",
        textStyleSkip: ktsGoalLabel.copyWith(color: Colors.white),
        paddingFocus: 0,
        //     onClickOverlay: (target) {
        //   print(target);
        // },
        // paddingFocus: 0,
        // opacityShadow: 0.8,
        onFinish: onFinish,

        onClickTarget: (target) => onTargetPressed(),
        onSkip: onSkip,
      );
    }
  }
  return null;
}
