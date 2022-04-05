import 'dart:io';

import 'package:flutter/material.dart';

import '../goal_list_screen/goal_list_screen.dart';
import './goal_type_item.dart';

class TypeScreenSetupWidget extends StatelessWidget {
  final BuildContext context;
  // final bool _wallAccess;
  final String _divisionName;
  final List<Map<String, Object>> _titleList;
  final List<Map<String, int>> _numOfGoalsInLists;
  final GlobalObjectKey _key;

  TypeScreenSetupWidget(
      this.context,
      // this._wallAccess,
      this._divisionName,
      this._titleList,
      this._numOfGoalsInLists,
      // this._popHandler,
      this._key);

  void categorySelected(
      {BuildContext context,
      String divisionName,
      String typeName,
      String imageUrl}) {
    // passing final values to next view
    Navigator.of(context).pushNamed(GoalScreen.routeName, arguments: {
      'divisionName': divisionName,
      'typeName': typeName,
      'imageUrl': imageUrl
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;
    double listViewContainerWidth = MediaQuery.of(context).size.width;

    double maxCrossAxisExtentVal;

    if (isLandscape) {
      // both landscape
      maxCrossAxisExtentVal = 200;
    } else if (!Platform.isIOS) {
      // android portrait
      if (listViewContainerWidth < 330) {
        maxCrossAxisExtentVal = 150;
      } else {
        maxCrossAxisExtentVal = 260;
      }
    } else {
      // iOS portrait
      if (listViewContainerWidth < 330) {
        maxCrossAxisExtentVal = 150;
      } else {
        maxCrossAxisExtentVal = 300;
      }
    }

    return _numOfGoalsInLists == null
        ? Center(
            child: Text(
              'Something went wrong',
              // key: _key,
            ),
          )
        // *** BUILD GRID VIEW FOR EACH CATEGORY ITEM
        : GridView(
            padding: const EdgeInsets.all(25),
            children:
                // *** BUILD EACH CATEGORY BUTTON
                _titleList
                    .map((item) => GoalTypeItem(
                        '${item['name']}',
                        '${item['imageUrl']}',
                        // this will determine whether Pro & Premium labels displayed on catergory button
                        // item['access'] == 'all' ? true : _wallAccess,
                        () => categorySelected(
                            context: context,
                            divisionName: _divisionName,
                            typeName: '${item['name']}',
                            imageUrl: '${item['imageUrl']}'),
                        _numOfGoalsInLists.length < 1
                            ? 0
                            : _numOfGoalsInLists.firstWhere((element) => element
                                .containsKey(item['name']))[item['name']],
                        item['name'] == 'Health/Fitness' &&
                                _divisionName == 'Short Term Goals'
                            ? _key
                            : null))
                    .toList(),
            // gridDelegate is an import argument of GridView
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                // this SliverGrid... is where you can customize your GridView specifications
                maxCrossAxisExtent: maxCrossAxisExtentVal,
                childAspectRatio: 6 / 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
  }
}
