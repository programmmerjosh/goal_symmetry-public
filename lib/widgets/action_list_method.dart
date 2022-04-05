import 'package:flutter/material.dart';

List<Widget> buildCustomElevatedButtonForAdaptiveAlert(
    {@required String dismissButtonText,
    @required String actionButton1Text,
    @required String actionButton2Text,
    @required Function actionButton1Handler,
    @required Function actionButton2Handler,
    @required BuildContext context}) {
  var _response = false;
  List<Widget> _actionList = [];

  if (dismissButtonText != null) {
    _actionList.add(Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 6),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                actionButton1Text == null
                    ? Color(0xFF1BC0C5)
                    : Color(0xFFfe5448))),
        onPressed: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            dismissButtonText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
    _response = true;
  }

  if (actionButton1Text != null) {
    if (dismissButtonText != null) {
      _actionList.add(SizedBox(
        width: 10.0,
      ));
    }
    _actionList.add(Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 6),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                actionButton2Text == null
                    ? Color(0xFF1BC0C5)
                    : Color(0xFFfe5448))),
        onPressed: actionButton1Handler,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            actionButton1Text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
    _response = true;
  }

  if (actionButton2Text != null) {
    if (actionButton1Text != null || dismissButtonText != null) {
      _actionList.add(SizedBox(
        width: 10.0,
      ));
    }
    _actionList.add(Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 6),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Color(0xFF1BC0C5))),
        onPressed: actionButton2Handler,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            actionButton2Text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
    _response = true;
  }

  if (!_response) {
    _actionList.add(Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 6),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Color(0xFF1BC0C5))),
        onPressed: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Text(
            'Okay',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
  }
  return _actionList;
}
