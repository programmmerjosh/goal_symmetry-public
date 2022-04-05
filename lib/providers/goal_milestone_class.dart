import 'package:flutter/material.dart';

class GoalMilestone {
  final String id;
  final String title;
  final DateTime dateCreated;
  final bool completed;

  GoalMilestone(
      {@required this.id,
      @required this.title,
      @required this.dateCreated,
      this.completed = false});
}
