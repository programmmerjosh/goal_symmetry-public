import 'package:flutter/material.dart';

import './goal_milestone_class.dart';
import './goal_notes.dart';

class Goal {
  final String id;
  final String title;
  final String division;
  final String type;
  final DateTime dateCreated;
  final DateTime deadlineDate;
  final String deadlineAlert; // example: 2 hours
  final DateTime goalAchievedDate;
  final int progress;
  final bool wall;
  final bool displayDeadlineCountdown;
  final bool animateTimer;
  final List<GoalMilestone> milestones;
  final List<GoalNote> notes;
  final bool progressManagementByProgressBar;
  final int goalIndexForDb;

  Goal(
      {@required this.title,
      @required this.division,
      @required this.type,
      @required this.dateCreated,
      this.deadlineAlert,
      this.deadlineDate,
      this.goalAchievedDate,
      this.progress = 0,
      this.id,
      this.wall = false,
      this.displayDeadlineCountdown,
      this.animateTimer,
      this.milestones,
      this.notes,
      this.goalIndexForDb,
      this.progressManagementByProgressBar = true});
}
