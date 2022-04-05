import 'package:flutter/material.dart';

enum TourButtonType { done, next }

class TourButton extends StatelessWidget {
  final Function btnHandler;
  final TourButtonType type;

  TourButton({@required this.btnHandler, this.type});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnHandler,
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: type == TourButtonType.done
                ? Theme.of(context).splashColor
                : Theme.of(context).primaryColor),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FittedBox(
            child: Row(
              children: [
                Icon(
                  type == TourButtonType.done ? Icons.done : Icons.skip_next,
                  size: 30,
                  color: type == TourButtonType.done
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  type == TourButtonType.done ? 'Done' : 'Next',
                  style: TextStyle(
                      color: type == TourButtonType.done
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
