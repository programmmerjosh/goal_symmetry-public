import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidablePosition { firstOnLeft, secondOnLeft, firstOnRight, secondOnRight }

class GoalItemSlidable extends StatelessWidget {
  final Decoration decoration;
  final bool itemOnWall;
  final Function leftSideFirstActionPressed;
  final Function leftSideSecondActionPressed;
  final Function rightSideFirstActionPressed;
  final Function rightSideSecondActionPressed;
  final Widget child;

  GoalItemSlidable(
      {this.decoration,
      this.itemOnWall = false,
      @required this.child,
      @required this.leftSideFirstActionPressed,
      @required this.leftSideSecondActionPressed,
      @required this.rightSideFirstActionPressed,
      @required this.rightSideSecondActionPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Slidable(
          // Specify a key if the Slidable is dismissible.
          // key: key,

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            // dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                label: 'Review Goal',
                backgroundColor: Colors.blue,
                icon: Icons.looks,
                // onPressed: leftSideFirstActionPressed,
                onPressed: (ctx) => leftSideFirstActionPressed(),
              ),
              SlidableAction(
                  label: 'Goal Notes',
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  icon: Icons.book_rounded,
                  onPressed: (ctx) => leftSideSecondActionPressed()),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                  // An action can be bigger than the others.
                  // flex: 2,
                  label: 'Send To ${itemOnWall ? "Goals" : "Wall"}',
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black45,
                  icon: Icons.send,
                  onPressed: (ctx) => rightSideFirstActionPressed()),
              SlidableAction(
                foregroundColor: Colors.white,
                label: 'Delete',
                backgroundColor: Color(0xFFFE4A49),
                icon: Icons.delete,
                onPressed: (ctx) => rightSideSecondActionPressed(),
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: child,
        ),
      ),
    );
  }
}

class MilestoneItemSlidable extends StatelessWidget {
  final Key key;
  final Function leftActionPressed;
  final Function rightActionPressed;
  final Widget child;
  final double paddingBottom;
  final double paddingTop;
  final double paddingOutside;
  final double paddingInside;
  final double roundedEdges;

  MilestoneItemSlidable(
      {@required this.key,
      @required this.child,
      this.paddingBottom = 0,
      this.paddingOutside = 0,
      this.paddingTop = 0,
      this.paddingInside = 0,
      this.roundedEdges = 6,
      @required this.leftActionPressed,
      @required this.rightActionPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(roundedEdges),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: key,
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (ctx) => leftActionPressed(),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Edit',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              foregroundColor: Colors.white,
              label: 'Delete',
              backgroundColor: Color(0xFFFE4A49),
              icon: Icons.delete,
              onPressed: (ctx) => rightActionPressed(),
            ),
          ],
        ),
        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: child,
      ),
    );
  }
}
