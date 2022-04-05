import 'package:flutter/material.dart';

import '../../custom_styles/custom_box_decorations.dart';
import '../../custom_styles/custom_text_styles.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: textBlockBoxDecoration(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: const Text(
                            'If this app finds you encouraged to set and pursue your own goals, AWESOME! Hope you enjoy it.',
                            style: ktsGoalLabel,
                          ),
                        ),
                      );
  }
}