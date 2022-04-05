import 'package:flutter/material.dart';

import '../../custom_styles/custom_box_decorations.dart';
import '../../custom_styles/custom_text_styles.dart';

class QuoteSection extends StatelessWidget {
  const QuoteSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: textBlockBoxDecoration(context),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '\"You don\'t have to be great to get started, but you have to get started to be great!\"',
                  style: ktsGoalLabel,
                ),
                Text(
                  'Ralph Waldo Emerson',
                  style: ktsGoalLabel.copyWith(
                      fontStyle: FontStyle.italic, fontSize: 14),
                ),
              ],
            ),
          )),
    );
  }
}
