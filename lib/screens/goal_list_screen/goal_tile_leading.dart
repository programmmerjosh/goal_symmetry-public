import 'package:flutter/material.dart';

import '../../custom_styles/custom_colors.dart';
import '../../custom_styles/custom_text_styles.dart';

class GoalTileLeading extends StatelessWidget {
  final String imageUrl;
  final String divisionName;
  final double progress;
  final AnimationController animationController;
  final double difference;
  final bool progressByProgressBar;
  final bool forwardAnimation;
  final double progressFrom;

  GoalTileLeading(
      {@required this.imageUrl,
      @required this.divisionName,
      @required this.progress,
      @required this.animationController,
      @required this.progressByProgressBar,
      this.progressFrom = 0,
      this.forwardAnimation = true,
      this.difference = 0});

  @override
  Widget build(BuildContext context) {
    final int _indexOfSpace = divisionName.indexOf(' ', 0) != -1
        ? divisionName.indexOf(' ', 0)
        : divisionName.length;

    return Container(
      width: 60,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/$imageUrl'),
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all((6)),
                child: FittedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        divisionName.substring(0, _indexOfSpace),
                        // textAlign: TextAlign.center,
                        style: ktsGoalAvatar,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 150,
              height: 150,
              child: AnimatedBuilder(
                animation: animationController,
                child: Container(),
                builder: (ctx, child) => CircularProgressIndicator(
                  strokeWidth: 12,
                  value:
                      // this works
                      progressByProgressBar
                          ?
                          // PROGRESS BAR
                          (progress * animationController.value)
                          : forwardAnimation
                              // MILESTONES => FORWARD()
                              ? progressFrom +
                                  animationController.value * difference
                              :
                              // MILESTONES => REVERSE()
                              (progress +
                                  (animationController.value * difference)),
                  valueColor:
                      (const AlwaysStoppedAnimation<Color>(kTiffanyBlue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
