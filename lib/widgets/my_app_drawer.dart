import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../custom_styles/custom_elevated_button.dart';
import './inkWellButton.dart';
import '../custom_styles/custom_text_styles.dart';
import '../screens/theme_selection_screen/change_theme_screen.dart';
import '../screens/tabs_screen/tabs_scaffold.dart';
import '../screens/purchases_screen/purchases_screen.dart';
import '../screens/wall_of_achievements/wall_of_achievements_screen.dart';
import '../screens/additional_info_screen/additional_info_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/introduction_screen/introduction_menu.dart';
import '../new_providers/auth.dart';
import '../widgets/adaptiveAlertDialog.dart';

class MyAppDrawer extends StatelessWidget {
  final bool sentfromWall;
  final String currentPageTitle;

  MyAppDrawer({this.sentfromWall = false, @required this.currentPageTitle});

  Future<void> logUserOut(BuildContext context) async {
    String currentRouteName = ModalRoute.of(context).settings.name;

    // these next few lines of code should execute regardless of the dialog answer.
    if (Provider.of<Auth>(context, listen: false).sessionTimeLeft != null) {
      if (currentRouteName != '/') {
        Navigator.pushReplacementNamed(context, '/');
      }
      var auth = Provider.of<Auth>(context, listen: false);
      await auth.logout(context, tempLogout: true);
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> _checkUserFutureLoginPreference(BuildContext context) async {
    Navigator.pop(context);
    final prefs = await SharedPreferences.getInstance();
    String autoLogin = prefs.getString('alwaysAutoLogin');
    if (autoLogin != 'No. I Prefer To Login Manually' &&
        autoLogin !=
            'Yes. Save My App-Login-Credentials To This Device And Login Automatically When I Open The App') {
      showDialog(
        context: context,
        builder: (context) => AdaptiveAlertDialog(
          title: 'Logout',
          contentText: 'You will now be logged out.\n\n'
              'For convenience, next time you open Goal Symmetry, would you like '
              'to be automatically logged in with your most recent login '
              'credentials?',
          actionButton1Text: 'No. Next time, I will login manually',
          actionButton1Handler: () {
            prefs.remove('userData');
            prefs.setString(
                'alwaysAutoLogin', 'No. I Prefer To Login Manually');
            // Navigator.of(context).pop();
            Navigator.pop(context);
            logUserOut(context);
          },
          actionButton2Text: 'Yes. Next time, auto-login for me',
          actionButton2Handler: () {
            prefs.setString('alwaysAutoLogin',
                'Yes. Save My App-Login-Credentials To This Device And Login Automatically When I Open The App');
            // Navigator.of(context).pop();
            Navigator.pop(context);
            logUserOut(context);
          },
        ),
      );
    } else {
      logUserOut(context);
    }
  }

  // MyAppDrawer([this.sentfromWall = false]);
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;
    // String currentRouteName = ModalRoute.of(context).settings.name;

    return Container(
      // color: Theme.of(context).hoverColor,
      color: Theme.of(context).primaryColor,
      height: double.infinity,
      width: isLandscape ? 280 : 220,
      child: Padding(
        padding: isLandscape
            ? const EdgeInsets.symmetric(horizontal: 50)
            : const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              // goals
              InkWellButton(
                handler: currentPageTitle == 'Goals'
                    ? () => Navigator.of(context).pop()
                    : () => Provider.of<Auth>(context, listen: false)
                        .executeOnlyIfSessionHasTimeLeft(
                            context,
                            () => Navigator.of(context)
                                .pushReplacementNamed(TabsScaffold.routeName)),
                title: 'Goals',
                buttonWidth: double.infinity,
                leadingIcon: Icons.golf_course_sharp,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonBorderColor: currentPageTitle == 'Goals'
                    ? Colors.white
                    : Colors.transparent,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              // wall
              InkWellButton(
                handler: currentPageTitle == 'Wall'
                    ? () => Navigator.of(context).pop()
                    : () => Provider.of<Auth>(context, listen: false)
                        .executeOnlyIfSessionHasTimeLeft(
                            context,
                            () => Navigator.of(context).pushReplacementNamed(
                                WallOfAchievementsScreen.routeName)),
                title: 'Wall',
                buttonWidth: double.infinity,
                leadingIcon: Icons.wallet_giftcard,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonBorderColor: currentPageTitle == 'Wall'
                    ? Colors.white
                    : Colors.transparent,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              // themes
              InkWellButton(
                handler: currentPageTitle == 'Themes'
                    ? () => Navigator.of(context).pop()
                    : () => Provider.of<Auth>(context, listen: false)
                        .executeOnlyIfSessionHasTimeLeft(
                            context,
                            () => Navigator.of(context).pushReplacementNamed(
                                ChangeThemeScreen.routeName)),
                title: 'Themes',
                buttonWidth: double.infinity,
                leadingIcon: Icons.collections,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                buttonBorderColor: currentPageTitle == 'Themes'
                    ? Colors.white
                    : Colors.transparent,
                buttonTextAlign: TextAlign.left,
                splashColor: Colors.black,
              ),
              const SizedBox(
                height: 6,
              ),
              // settings
              InkWellButton(
                handler: () => Provider.of<Auth>(context, listen: false)
                    .executeOnlyIfSessionHasTimeLeft(
                        context,
                        () => Navigator.of(context)
                            .popAndPushNamed(SettingsScreen.routeName)),
                title: 'Settings',
                buttonWidth: double.infinity,
                leadingIcon: Icons.settings,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              // store
              InkWellButton(
                handler: currentPageTitle == 'Store'
                    ? () => Navigator.of(context).pop()
                    : () => Provider.of<Auth>(context, listen: false)
                        .executeOnlyIfSessionHasTimeLeft(
                            context,
                            () => Navigator.of(context).pushReplacementNamed(
                                PurchasesScreen.routeName)),
                title: 'Store',
                buttonWidth: double.infinity,
                leadingIcon: Icons.fence,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonBorderColor: currentPageTitle == 'Store'
                    ? Colors.white
                    : Colors.transparent,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              // info
              InkWellButton(
                handler: () => Provider.of<Auth>(context, listen: false)
                    .executeOnlyIfSessionHasTimeLeft(
                        context,
                        () => Navigator.of(context)
                            .popAndPushNamed(AdditionalInfoScreen.routeName)),
                title: 'Info',
                buttonWidth: double.infinity,
                leadingIcon: Icons.info,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              // tutorials
              InkWellButton(
                handler: () => Provider.of<Auth>(context, listen: false)
                    .executeOnlyIfSessionHasTimeLeft(
                        context,
                        () => Navigator.of(context)
                            .popAndPushNamed(IntroMenuScreen.routeName)),
                title: 'Tutorials',
                buttonWidth: double.infinity,
                leadingIcon: Icons.slideshow,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 6,
              ),
              // logout
              InkWellButton(
                handler: () => Provider.of<Auth>(context, listen: false)
                    .executeOnlyIfSessionHasTimeLeft(context,
                        () => _checkUserFutureLoginPreference(context)),
                title: 'Logout',
                buttonWidth: double.infinity,
                leadingIcon: Icons.exit_to_app,
                textStyle: ktsPrimaryWhite,
                backgroundColor: Theme.of(context).primaryColor,
                splashColor: Colors.black,
                buttonTextAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
