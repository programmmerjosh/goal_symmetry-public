// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../widgets/inkWellButton.dart';

Future buildEditGoalBottomSheet(
    BuildContext context, String id, Function tapHandler) {
  bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape
      ? true
      : false;
  DateTime tempDate;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: isLandscape
              ? 0.9
              : 0.8, // this will adjust the bottom sheet height
          child: Container(
            color: Theme.of(context).disabledColor,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                      style: BorderStyle.solid),
                  color: Theme.of(context).hoverColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Text(
                      'Set Deadline',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).backgroundColor == Colors.black
                          ? ktsGoalTypeItem.copyWith(color: Colors.white)
                          : ktsGoalTypeItem.copyWith(
                              color: Theme.of(context).primaryColor),
                    ),
                    const Divider(),
                    // if (Platform.isIOS)
                    Container(
                      width: double.infinity,
                      height: isLandscape ? 180 : 200,
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle: TextStyle(
                                    color: Theme.of(context).backgroundColor ==
                                            Colors.black
                                        ? Colors.white
                                        : Colors.black))),
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now().add(Duration(
                              minutes: 15 - DateTime.now().minute % 15)),
                          minuteInterval: 15,
                          onDateTimeChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            tempDate = value;
                          },
                        ),
                      ),
                    ),
                    // if (Platform.isIOS)
                    const Divider(),
                    // if (Platform.isIOS)
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWellButton(
                                handler: () => Navigator.of(context).pop(),
                                title: 'Cancel',
                                textStyle: ktsPrimaryWhite.copyWith(
                                    color: Theme.of(context).primaryColor),
                                backgroundColor: Colors.white,
                                buttonBorderColor:
                                    Theme.of(context).primaryColor,
                                splashColor: Colors.black12,
                              ),
                            ),
                            Expanded(
                              child: InkWellButton(
                                handler: () => tapHandler(tempDate),
                                title: 'Set',
                                textStyle: ktsPrimaryWhite,
                                backgroundColor: Theme.of(context).primaryColor,
                                buttonBorderColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
