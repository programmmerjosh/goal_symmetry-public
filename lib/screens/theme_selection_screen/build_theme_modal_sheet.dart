// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/tabs_screen/tabs_scaffold.dart';
import '../../custom_styles/custom_text_styles.dart';
import '../purchases_screen/purchases_screen.dart';
import '../../widgets/inkWellButton.dart';

Future buildShowThemeScreenModalSheet(
    {BuildContext context,
    String themeName,
    // String themePurchaseId,
    String specificSelectedThemeId,
    SharedPreferences deviceData,
    bool available}) {
  bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape
      ? true
      : false;

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: isLandscape
              ? 0.6
              : 0.4, // this will adjust the bottom sheet height
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          themeName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).backgroundColor ==
                                  Colors.black
                              ? ktsGoalTypeItem.copyWith(color: Colors.white)
                              : ktsGoalTypeItem.copyWith(
                                  color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWellButton(
                          handler: () {
                            Navigator.of(context).pop();
                            if (!available) {
                              Navigator.of(context).pushReplacementNamed(
                                  PurchasesScreen.routeName);
                            } else {
                              deviceData.setString('previouslySavedThemeId',
                                  specificSelectedThemeId);
                              Navigator.of(context)
                                  .pushReplacementNamed(TabsScaffold.routeName);
                            }
                          },
                          title: available ? 'Done ✔' : 'Get Theme',
                          textStyle: ktsPrimaryWhite,
                          backgroundColor: Theme.of(context).primaryColor,
                          buttonWidth: 200,
                          buttonBorderColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWellButton(
                          handler: () => Navigator.of(context).pop(),
                          title: 'Hide',
                          textStyle: ktsPrimaryWhite.copyWith(
                              color: Theme.of(context).primaryColor),
                          backgroundColor: Colors.white,
                          buttonWidth: 170,
                          buttonBorderColor: Theme.of(context).primaryColor,
                          splashColor: Colors.black12,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  )),
            ),
          ),
        );
      });
}
