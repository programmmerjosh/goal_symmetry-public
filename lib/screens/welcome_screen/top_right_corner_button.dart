import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../custom_styles/custom_colors.dart';

class TopRightCornerButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  const TopRightCornerButton(
      {Key key, @required this.title, @required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: IconButton(
                icon: FittedBox(
                  child: Column(
                    children: [
                      Icon(icon ?? Icons.info_rounded,
                          color: kOrangeRedCrayola),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        title,
                        style: ktsGoalLabel.copyWith(color: kOrangeRedCrayola),
                      )
                    ],
                  ),
                ),
                onPressed: onPressed),
          ),
        )
      ],
    );
  }
}
