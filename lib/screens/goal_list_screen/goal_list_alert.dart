import 'package:flutter/material.dart';

import '../../widgets/adaptiveAlertDialog.dart';

class GoalListAlert extends StatelessWidget {
  final Function onPressed;

  GoalListAlert({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return AdaptiveAlertDialog(
      title: 'Remove Goal',
      contentText: 'Are you sure you want to delete this goal?',
      actionButton1Text: 'No',
      actionButton1Handler: () => Navigator.of(context).pop(false),
      actionButton2Text: 'Yes',
      actionButton2Handler: () {
        Navigator.of(context).pop(true);
        onPressed();
      },
    );
  }
}
