import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:overlay_support/overlay_support.dart';

import './providers/app_theme_data.dart';
import './screens/welcome_screen/welcome_screen.dart';
import './screens/tabs_screen/tabs_scaffold.dart';
import './screens/goal_list_screen/goal_list_screen.dart';
import './screens/edit_goal_screen/edit_goal_screen.dart';
import './screens/purchases_screen/purchases_screen.dart';
import './screens/additional_info_screen/additional_info_screen.dart';
import './screens/theme_selection_screen/change_theme_screen.dart';
import './screens/wall_of_achievements/wall_of_achievements_screen.dart';
import './screens/goal_notes_screen/goal_notes_screen.dart';
import './screens/settings_screen.dart';
import './screens/introduction_screen/introduction_screen.dart';
import './screens/introduction_screen/introduction_menu.dart';
import './screens/attributions.dart';
import './screens/auth_screen2point0.dart';
import './screens/pro_and_premium_paywall_screen.dart';
import './new_providers/auth.dart';
import './new_providers/data.dart';

// => push-notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  try {
    startPushNotificationSetup();
  } catch (error) {
    print('error setting up push notifications');
  }
  runApp(OverlaySupport.global(child: Phoenix(child: MyApp())));
}

// => push-notifications
Future<void> startPushNotificationSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('splash_icon');
  var initializingSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializingSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      // debugPrint('notification payload: ' + payload);
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        saveThemesOnChange:
            true, // this will save a theme to disk on any theme change
        loadThemeOnInit:
            true, // this will load the previously saved theme on startup
        themes: [
          // first theme will always be default theme unless another theme was saved
          AppTheme(
              id: "stockstandardlight",
              data: stockStandardLight,
              description: 'default theme'),
          AppTheme(
              id: "classiclight",
              data: classiclight,
              description: 'free theme'),
          ...MyThemes.all.map((e) => e['light']).toList(),
          ...MyThemes.all.map((e) => e['dark']).toList(),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (c) => Auth()),
            ChangeNotifierProxyProvider<Auth, GoalDatav2>(
                create: (_) => null,
                update: (ctx, auth, previousData) => GoalDatav2(
                    auth.token,
                    auth.userId,
                    previousData == null || previousData.myGoals == null
                        ? []
                        : previousData.dbGoals))
          ],
          child: ThemeConsumer(
            child: Consumer<Auth>(
              builder: (ctx, auth, _) => Builder(
                builder: (themeContext) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Goal Symmetry',
                  theme: ThemeProvider.themeOf(themeContext).data,
                  home: auth.isAuthenticated
                      ? FutureBuilder(
                          builder: (ctx, asyncSnapshot) =>
                              asyncSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreenWidget()
                                  : (asyncSnapshot.data
                                      ? TabsScaffold()
                                      : WelcomeScreen()),
                          future: auth
                              .hideWelcomeScreen(auth.sessionTimeLeft != null),
                        )
                      : FutureBuilder(
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreenWidget()
                                  : AuthScreen2(),
                          future: auth.userAlreadyLoggedIn(context)),
                  routes: {
                    AuthScreen2.routeName: (context) => AuthScreen2(),
                    WelcomeScreen.routeName: (context) => WelcomeScreen(),
                    TabsScaffold.routeName: (context) => TabsScaffold(),
                    GoalScreen.routeName: (context) => GoalScreen(),
                    EditGoalScreen.routeName: (context) => EditGoalScreen(),
                    AdditionalInfoScreen.routeName: (context) =>
                        AdditionalInfoScreen(),
                    WallOfAchievementsScreen.routeName: (context) =>
                        WallOfAchievementsScreen(),
                    ChangeThemeScreen.routeName: (context) =>
                        ChangeThemeScreen(),
                    PurchasesScreen.routeName: (context) => PurchasesScreen(),
                    GoalNotesScreen.routeName: (context) => GoalNotesScreen(),
                    SettingsScreen.routeName: (context) => SettingsScreen(),
                    IntroScreen.routeName: (context) => IntroScreen(),
                    IntroMenuScreen.routeName: (context) => IntroMenuScreen(),
                    AttributionsScreen.routeName: (context) =>
                        AttributionsScreen(),
                    ProAndPremiumPaywall.routeName: (context) =>
                        ProAndPremiumPaywall(),
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
