import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget _child;
  final Function _btnHandler;

  CustomElevatedButton(this._btnHandler, this._child);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      autofocus: true,
      style: ElevatedButton.styleFrom(
          animationDuration: Duration(milliseconds: 1500),
          elevation: 6,
          textStyle: TextStyle(
            fontFamily: 'var-roman',
          ),
          primary: Colors.transparent,
          // fixedSize: Size.fromWidth(fixedWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: _child,
      ),
      onPressed: _btnHandler,
    );
  }
}
