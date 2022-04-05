import 'package:flutter/material.dart';

class DismissBackground extends StatelessWidget {
  final Color swipeColor;
  final IconData icon;
  final AlignmentGeometry alignment;

  DismissBackground(this.swipeColor, this.icon, this.alignment);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: swipeColor,
      child: Icon(
        icon,
        color: Colors.white,
        size: 40,
      ),
      alignment: alignment,
      padding: alignment == Alignment.centerLeft
          ? EdgeInsets.only(left: 20)
          : EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    );
  }
}
