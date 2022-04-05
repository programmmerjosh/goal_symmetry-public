import 'package:flutter/material.dart';

import 'package:overlay_support/overlay_support.dart';

import '../custom_styles/custom_text_styles.dart';

void showCustomSimpleSnackbar(BuildContext context,
    {String message, IconData icon, Duration duration}) {
  showSimpleNotification(Container(),
      autoDismiss: true,
      background: Theme.of(context).primaryColor,
      contentPadding: EdgeInsets.all(10),
      context: context,
      duration: duration == null ? Duration(milliseconds: 1500) : duration,
      elevation: 6,
      leading: Text(
        message == null ? '' : message,
        style: ktsGoalTypeItem.copyWith(color: Colors.white),
      ),
      position: NotificationPosition.top,
      slideDismissDirection: DismissDirection.up,
      trailing: Icon(icon != null ? icon : Icons.check_circle_outline,
          color: Colors.white));
}
