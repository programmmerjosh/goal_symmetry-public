import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../custom_styles/custom_colors.dart';
import '../../custom_styles/custom_box_decorations.dart';

class AlertBlock extends StatelessWidget {
  final String _selectedAlert;
  AlertBlock(this._selectedAlert);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Alert: ',
          style: ktsGoalLabel,
          softWrap: false,
        ),
        FittedBox(
          fit: BoxFit.cover,
          child: Container(
            decoration: textBlockBoxDecoration(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                children: [
                  Text(
                    '${_selectedAlert.toLowerCase()}',
                    style: ktsGoalLabel.copyWith(
                      fontWeight: FontWeight.w700,
                      // fontSize: 16,
                      color: kTiffanyBlue,
                    ),
                  ),
                  Text(
                    ' before deadline',
                    style: ktsGoalLabel.copyWith(
                        fontWeight: FontWeight.w700,
                        // fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
