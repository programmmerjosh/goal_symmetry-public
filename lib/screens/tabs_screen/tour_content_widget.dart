import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';
import './tour_button.dart';

class TourContentWidget extends StatelessWidget {
  final String title;
  final String description;
  final Function onPress;
  final TourButtonType type;
  final EdgeInsetsGeometry padding;

  TourContentWidget(
      {@required this.title,
      @required this.description,
      this.type,
      this.padding,
      @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: ktsGoalTypeItem.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                description,
                style: ktsGoalLabel.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
