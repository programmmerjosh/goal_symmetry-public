import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../custom_styles/custom_colors.dart';
import '../../custom_styles/custom_box_decorations.dart';

class DateBlock extends StatelessWidget {
  final DateTime _selectedDate;
  DateBlock(this._selectedDate);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Deadline: ',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DateFormat.yMMMd().format(_selectedDate)}',
                    style: ktsGoalLabel.copyWith(
                        fontWeight: FontWeight.w700,
                        // fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                  Text(
                    ' ${DateFormat.Hm().format(_selectedDate)}',
                    style: ktsGoalLabel.copyWith(
                      fontWeight: FontWeight.w700,
                      // fontSize: 17,
                      color: kTiffanyBlue,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
