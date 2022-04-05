import 'package:flutter/material.dart';

// import '../../custom_styles/custom_elevated_button.dart';
import '../../custom_styles/custom_text_styles.dart';

class ThemeOptionTile extends StatelessWidget {
  final BuildContext themeContext;
  final String themeTitle;
  final Color btnColorLightTheme;
  final Color btnColorDarkTheme;
  final Function lightThemeHandler;
  final Function darkThemeHandler;
  final bool currentlySelectedTheme;

  ThemeOptionTile(
      {this.themeContext,
      @required this.themeTitle,
      @required this.btnColorLightTheme,
      @required this.btnColorDarkTheme,
      @required this.lightThemeHandler,
      @required this.darkThemeHandler,
      this.currentlySelectedTheme = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          // This is the border for the whole theme row
          border: Border.all(
              color: currentlySelectedTheme
                  ? (btnColorLightTheme == Colors.white
                      ? btnColorDarkTheme
                      : btnColorLightTheme)
                  : Colors.transparent,
              style: BorderStyle.solid,
              width: 4.0),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            child: Container(
              // color: Colors.blue,
              width: 100,
              child: Text(
                themeTitle,
                style: ktsGoalTypeItem.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // light button
          Container(
            decoration: BoxDecoration(
                color: btnColorLightTheme,
                border: Border.all(
                    color: currentlySelectedTheme
                        ? btnColorLightTheme == Colors.white
                            ? Theme.of(context).primaryColor
                            : Colors.white
                        : Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                    width: 4.0),
                borderRadius: BorderRadius.circular(10)),
            width: 120,
            height: 60,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Text('Light',
                        style: ktsPrimaryWhite.copyWith(
                          color: currentlySelectedTheme
                              ? btnColorLightTheme == Colors.white
                                  ? Theme.of(context).primaryColor
                                  : Colors.white
                              : Theme.of(context).primaryColor,
                        )),
                  ),
                  onTap: lightThemeHandler,
                  splashColor: btnColorLightTheme == Colors.white
                      ? Colors.black12
                      : Colors.black),
            ),
          ),
          // dark button
          Container(
            decoration: BoxDecoration(
                color: btnColorDarkTheme,
                border: Border.all(
                    color: currentlySelectedTheme
                        ? btnColorDarkTheme == Colors.white
                            ? Theme.of(context).primaryColor
                            : Colors.white
                        : Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                    width: 4.0),
                borderRadius: BorderRadius.circular(10)),
            width: 120,
            height: 60,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: Center(
                    child: Text('Dark',
                        style: ktsPrimaryWhite.copyWith(
                          color: currentlySelectedTheme
                              ? btnColorDarkTheme == Colors.white
                                  ? Theme.of(context).primaryColor
                                  : Colors.white
                              : Theme.of(context).primaryColor,
                        ))),
                onTap: darkThemeHandler,
                splashColor: btnColorDarkTheme == Colors.white
                    ? Colors.black12
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
