import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../providers/goal_data_class.dart';
import './done_animation.dart';

class GoalTileTrailing extends StatelessWidget {
  final double _progress;
  final DateTime _deadlineDate;
  final AnimationController _controller;
  final bool _animate;

  GoalTileTrailing(
    this._progress,
    this._deadlineDate,
    this._controller,
    this._animate,
  );

  @override
  Widget build(BuildContext context) {
    String displayText() {
      if (GoalData.minsBetween(_deadlineDate, DateTime.now()) <= 0) {
        return 'Time\nUp';
      } else if (GoalData.hoursBetween(_deadlineDate, DateTime.now()) > 24) {
        return 'D-day:\n${(DateFormat.yMMMd().format(_deadlineDate)).toString().replaceAll(', ', ',\n')}';
      } else if (GoalData.minsBetween(_deadlineDate, DateTime.now()) > 60) {
        return '${(GoalData.hoursBetween(_deadlineDate, DateTime.now()))}h${(GoalData.minsBetween(_deadlineDate, DateTime.now())) % 60}m\nleft';
      } else {
        return '${(GoalData.minsBetween(_deadlineDate, DateTime.now()))} m\nleft';
      }
    }

    var myAnimation;

    if (_animate) {
      _controller
        ..value = 0
        ..duration = Duration(seconds: 3)
        ..reset()
        ..forward();
      myAnimation = DoneAnimation(_controller, true);
    } else {
      myAnimation = DoneAnimation(_controller, false);
    }

    return (_progress == 100.0
        ? myAnimation
        : (_deadlineDate != null
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(displayText(),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center)))
            : const Text('')));
  }
}
