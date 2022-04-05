import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../screens/tabs_screen/tour_content_widget.dart';

Future<void> startTourOnFirstLaunch(
    BuildContext context, Function actionHandler) async {
  final prefs = await SharedPreferences.getInstance();
  var firstLaunch = prefs.getString('firstLaunch') ?? null;

  if (firstLaunch == null) {
    actionHandler();
    prefs.setString('firstLaunch', 'Nope, launched before');
  }
}

List<TargetFocus> buildStartupTutorial(
    Function onPressed,
// Key tabButtonKey,
//     Key categoryButtonKey,
    Key keyTutorialButton) {
  List<TargetFocus> targets = [];

  targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyTutorialButton,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: TourContentWidget(
              padding: EdgeInsets.zero,
              title: "First time using this app?",
              description:
                  "RECOMMENDED: Go through the short guided tutorials.",
              onPress: onPressed,
            ))
      ]));

  return targets;
}

List<TargetFocus> buildAddGoalTutorial(Function onPressed, Key keyAddButton) {
  List<TargetFocus> targets = [];

  targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyAddButton,
      paddingFocus: 5,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: TourContentWidget(
            padding: EdgeInsets.zero,
            title: "Press this plus button to begin",
            description:
                "It\'s as simple as typing in your goal followed by pressing the add button.",
            onPress: onPressed,
          ),
        )
      ]));
  return targets;
}
