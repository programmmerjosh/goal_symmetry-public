import 'package:flutter/material.dart';
import '../introduction_screen/introduction_menu.dart';
// import 'package:flutter/cupertino.dart';

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/tabs_screen/test_theme_purchased_method.dart';
import '../../helpers/iap.dart';
import '../../custom_styles/custom_box_decorations.dart';
import '../../custom_styles/custom_text_styles.dart';
import '../../new_providers/data.dart';
import '../../new_providers/auth.dart';
import '../../providers/goal_data_class.dart';
import '../../providers/app_theme_data.dart';
import '../../widgets/my_app_drawer.dart';
import '../overview_page.dart';
import './type_screen_setup_widget.dart';
import './build_bottom_navigation_bar.dart';
import './tutorial_methods.dart';
// import './start_tour_button.dart';
import './build_rating_prompt.dart';

class TabsScaffold extends StatefulWidget {
  static const routeName = '/tabs';

  final bool pushedFromWall;

  TabsScaffold({this.pushedFromWall = false});

  @override
  _TabsScaffoldState createState() => _TabsScaffoldState();
}

class _TabsScaffoldState extends State<TabsScaffold>
    with WidgetsBindingObserver {
  bool _once = false;
  // bool _wallAccess = false;
  // bool _tempProAccess = false;
  bool _tutorialInProgress = false;
  var navbarTitles = ['All Your Dreams', 'Short Term', 'Long Term', 'Dreams'];

  List<TargetFocus> targets = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalObjectKey _keyDrawerButton = GlobalObjectKey('drawerButton');
  GlobalObjectKey _keyTabButton = GlobalObjectKey('shortTermTab');
  GlobalObjectKey _keyCategoryButton = GlobalObjectKey('categoryButton');
  GlobalObjectKey _keyTutorialsButton = GlobalObjectKey('tutorialsButton');

  var _tut;

  static const _entitlementIds = [
    'gs_3999_1y_1m0',
    'tiffany_blue_theme',
    'oxford_blue_theme',
    'fire_brick_red_theme',
    'copper_crayola_theme',
    'pop_star_pink_theme',
    'gs_599_1m_1m0',
  ];

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 2,
    minLaunches: 4,
    remindDays: 2,
    remindLaunches: 3,
    googlePlayIdentifier: 'com.programmmerjosh.goal_symmetry',
    appStoreIdentifier: '1538288839',
  );

  @override
  void initState() {
    // PURCHASES CHECK
    // THIS CHECK SHOULD BASICALLY TEST IF A USER HAS A VALID SUBSCRIPTION
    // i.e.  THE PRO SUBSCRIPTION HAS NOT EXPIRED
    // IF THE SUBSCRIPTION HAS EXPIRED, OR USER GOT A REFUND FOR WHATEVER REASON,
    // THEN THE DEVICE STORED KEY VALUE PAIR, SHOULD BE REMOVED.
    // SAME WITH PREMIUM, OR ANY THEME PURCHASES, IF USER OPTS FOR A REFUND, THEN
    // DEVICE STORED KEY VALUE PAIRS SHOULD BE REMOVED.

    GSPurchases.initPlatformState().then((value) async {
      PurchaserInfo purchaserInfo;
      SharedPreferences prefs;
      try {
        Future.wait(
                [SharedPreferences.getInstance(), Purchases.getPurchaserInfo()])
            .then((value) {
          prefs = value.first;
          purchaserInfo = value.last;

          _entitlementIds.forEach((element) {
            bool itemPurchased =
                purchaserInfo.allPurchasedProductIdentifiers.contains(element);
            if (!itemPurchased) {
              // remove theme availability from device
              prefs.remove(element);

              String previouslySavedThemeId =
                  prefs.getString('previouslySavedThemeId');

              if (previouslySavedThemeId != null &&
                  previouslySavedThemeId != '') {
                String purchasedThemeId = MyThemes.all.firstWhere((element) =>
                    element['lightThemeId'] == previouslySavedThemeId ||
                    element['darkThemeId'] ==
                        previouslySavedThemeId)['themePurchaseId'];

                // and if that theme was previously saved, remove that saved data as well
                if (element == purchasedThemeId) {
                  prefs.remove('previouslySavedThemeId');
                }
              }
            } else {
              prefs.setString(element, 'purchased');
            }
          });
        });
      } catch (e) {
        // Error fetching purchaser info
      }
    });

    setupTour();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void showTutorial() {
    if (!_tutorialInProgress) {
      setState(() => _tutorialInProgress = true);
      selectPage(1);
      Future.delayed(
          Duration(milliseconds: 600),
          () => setState(() {
                _tut = buildTutorial(context, targets);
                _tut.show();
              }));
    }
  }

  TutorialCoachMark buildTutorial(
      BuildContext context, List<TargetFocus> targets) {
    return TutorialCoachMark(
      context,
      targets: targets, // List<TargetFocus>

      // colorShadow: Colors.red, // DEFAULT Colors.black
      // colorShadow: Color.fromRGBO(12, 12, 12, 0.1),
      opacityShadow: 0.7,
      // alignSkip: Alignment.bottomRight,

      textSkip: "CANCEL",
      // textSkip: "",
      textStyleSkip: ktsGoalLabel.copyWith(color: Colors.white),
      paddingFocus: 0,
      //     onClickOverlay: (target) {
      //   print(target);
      // },
      // paddingFocus: 0,
      // opacityShadow: 0.8,
      onFinish: () {
        setState(() => _tutorialInProgress = false);
        // print("finish");
      },

      onClickTarget: (target) {
        if (target.keyTarget == _keyTutorialsButton) {
          Navigator.pushNamed(context, IntroMenuScreen.routeName);
        }
      },
      onSkip: () {
        setState(() => _tutorialInProgress = false);
        // print("skip");
      },
    );
  }

  void setupTour() {
    setState(() {
      targets.clear();
      targets = buildStartupTutorial(() => _tut.next(), _keyTutorialsButton);
    });
  }

  int _selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void didChangeDependencies() async {
    if (!_once && mounted) {
      final prefs = await SharedPreferences.getInstance();
      try {
        _rateMyApp.init().then((_) {
          buildRatingPrompt(context, _rateMyApp);
        });
        testTheme(context, prefs);
        // _checkUserAccess(prefs);
        setState(() => _once = true);
      } catch (e) {
        print('TABS SCAFFOLD DID CHANGE DEPENDENCIES ERROR!!!');
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        // print('paused');
        break;
      case AppLifecycleState.inactive:
        // print('inactive from Tabs screen');
        break;
      case AppLifecycleState.resumed:
        // currently, this will only print to console on resumed
        // unless timeLeft becomes null, then Navigation to home will be executed
        Provider.of<Auth>(context, listen: false)
            .executeOnlyIfSessionHasTimeLeft(context, () {});
        break;
      case AppLifecycleState.detached:
        // print('detached');
        break;
      default:
        // print('mooochaka');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    startTourOnFirstLaunch(context, showTutorial);
    return ThemeProvider(
      child: Builder(
        builder: (themeContext) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: FittedBox(
                child: Text(
                  navbarTitles[_selectedPageIndex] != 'All Your Dreams'
                      ? "Goals -> ${navbarTitles[_selectedPageIndex]}"
                      : 'All Your Dreams',
                  style: ktsNavbarTitle,
                ),
              ),
              leading: IconButton(
                  key: _keyDrawerButton,
                  icon: Icon(Icons.apps),
                  onPressed: () => _scaffoldKey.currentState.openDrawer()),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.slideshow,
                      color: Theme.of(context).splashColor,
                      key: _keyTutorialsButton,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, IntroMenuScreen.routeName))
              ]),
          drawer: MyAppDrawer(
            currentPageTitle: 'Goals',
          ),
          body: GestureDetector(
              onHorizontalDragEnd: (value) {
                if (value.primaryVelocity > 0) {
                  // swipe left to right
                  setState(() {
                    _selectedPageIndex == 0
                        ? _selectedPageIndex = _selectedPageIndex
                        : _selectedPageIndex--;
                  });
                } else {
                  // swipe right to left
                  setState(() {
                    _selectedPageIndex == 3
                        ? _selectedPageIndex = _selectedPageIndex
                        : _selectedPageIndex++;
                  });
                }
                selectPage(_selectedPageIndex);
              },
              child: Container(
                width: double.infinity,
                decoration: scaffoldBodyBoxDecoration(context),
                child: Consumer<GoalDatav2>(
                    builder: (ctx, data, child) => [
                          OverviewPage(
                            pushedFromWall: false,
                          ),
                          TypeScreenSetupWidget(
                              context,
                              // _wallAccess || _tempProAccess,
                              'Short Term Goals',
                              GoalData.termList,
                              data.numOfShortGoalsPerCategory,
                              _keyCategoryButton),
                          TypeScreenSetupWidget(
                              context,
                              // _wallAccess || _tempProAccess,
                              'Long Term Goals',
                              GoalData.termList,
                              data.numOfLongGoalsPerCategory,
                              null),
                          TypeScreenSetupWidget(
                              context,
                              // _wallAccess || _tempProAccess,
                              'Dreams',
                              GoalData.dreamList,
                              data.numOfDreamGoalsPerCategory,
                              null),
                        ][_selectedPageIndex]),
              )),
          bottomNavigationBar: buildBottomNavigationBar(
              context, selectPage, _selectedPageIndex, _keyTabButton),
        ),
      ),
    );
  }
}
