import 'package:flutter/material.dart';

class GoalNote {
  final String id;
  final String title;
  final DateTime timestamp;
  final int noteIndexInDb;

  GoalNote(
      {@required this.id,
      @required this.title,
      @required this.timestamp,
      @required this.noteIndexInDb});
}
