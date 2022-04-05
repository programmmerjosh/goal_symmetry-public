import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../custom_styles/custom_colors.dart';
import '../tabs_screen/tabs_scaffold.dart';
import '../../widgets/inkWellButton.dart';

class ContinueButton extends StatelessWidget {
  // const ContinueButton({Key key}) : super(key: key);
  final Function _checkmarkTest;

  ContinueButton(this._checkmarkTest);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Column(
          children: [
            // CONTINUE BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWellButton(
                  handler: () {
                    _checkmarkTest();
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScaffold.routeName);
                  },
                  title: 'Continue',
                  buttonWidth: 200,
                  textStyle: ktsPrimaryWhite,
                  backgroundColor: kOrangeRedCrayola,
                  buttonBorderColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
