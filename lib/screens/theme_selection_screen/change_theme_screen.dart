import 'package:flutter/material.dart';

import 'package:theme_provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../new_providers/auth.dart';
import '../../custom_styles/custom_text_styles.dart';
import '../../widgets/my_app_drawer.dart';
import '../../custom_styles/custom_box_decorations.dart';
import '../../providers/app_theme_data.dart';
import './theme_option_tile.dart';
import './build_theme_modal_sheet.dart';

class ChangeThemeScreen extends StatefulWidget {
  static const routeName = '/theme-screen';

  @override
  _ChangeThemeScreenState createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  bool _bottomSheetVisible = false;
  var prefs;
  String selectedButton = '';
  // bool _hasLoaded = false;
  // bool _wallAccess = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _toggleBottomSheetVisibility() {
    setState(() {
      _bottomSheetVisible = !_bottomSheetVisible;
    });
  }

  // Future<SharedPreferences> getPrefs() async =>
  @override
  void didChangeDependencies() async {
    var a;
    try {
      a = await SharedPreferences.getInstance();
    } catch (error) {
    } finally {
      if (mounted)
        setState(() {
          prefs = a;
          selectedButton = prefs.getString('theme_provider.theme.default');
        });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(
        builder: (themeContext) => Scaffold(
          key: _scaffoldKey,
          drawer: MyAppDrawer(
            currentPageTitle: 'Themes',
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "Select Your Theme",
              style: ktsNavbarTitle,
            ),
            leading: IconButton(
                icon: Icon(Icons.apps),
                onPressed: () => _scaffoldKey.currentState.openDrawer()),
          ),
          body: Container(
            height: double.infinity,
            decoration: scaffoldBodyBoxDecoration(context),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 6, left: 3, right: 3),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: selectedButton == 'stockstandardlight' ||
                                      selectedButton == '' ||
                                      selectedButton == null
                                  ? stockStandardLight.primaryColor
                                  : Colors.transparent,
                              style: BorderStyle.solid,
                              width: 4.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // *** BUILD FIRST DEFAULT THEME ITEM TO SELECT
                          FittedBox(
                            child: Container(
                              width: 100,
                              child: Text(
                                'Standard',
                                style: ktsGoalTypeItem.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: selectedButton == 'stockstandardlight'
                                    ? stockStandardLight.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                    color:
                                        selectedButton == 'stockstandardlight'
                                            //      ||
                                            // selectedButton == '' ||
                                            // selectedButton == null
                                            ? Colors.white
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
                                  child: Text(
                                    'Light',
                                    style: ktsPrimaryWhite.copyWith(
                                      color:
                                          selectedButton == 'stockstandardlight'
                                              ? Colors.white
                                              : Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () {
                                  Provider.of<Auth>(context, listen: false)
                                      .executeOnlyIfSessionHasTimeLeft(context,
                                          () {
                                    ThemeProvider.controllerOf(context)
                                        .setTheme('stockstandardlight');
                                    // print('change theme');
                                  });
                                  setState(() =>
                                      selectedButton = 'stockstandardlight');
                                },
                                splashColor:
                                    selectedButton == 'stockstandardlight'
                                        ? Colors.black
                                        : Colors.black12,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: 120,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: selectedButton == 'classiclight' ||
                                      selectedButton == '' ||
                                      selectedButton == null
                                  ? classiclight.primaryColor
                                  : Colors.transparent,
                              style: BorderStyle.solid,
                              width: 4.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // *** BUILD FIRST DEFAULT THEME ITEM TO SELECT
                          FittedBox(
                            child: Container(
                              width: 100,
                              child: Text(
                                'Classic',
                                style: ktsGoalTypeItem.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: selectedButton == 'classiclight'
                                    ? classiclight.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                    color: selectedButton == 'classiclight'
                                        //      ||
                                        // selectedButton == '' ||
                                        // selectedButton == null
                                        ? Colors.white
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
                                  child: Text(
                                    'Light',
                                    style: ktsPrimaryWhite.copyWith(
                                      color: selectedButton == 'classiclight'
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () {
                                  Provider.of<Auth>(context, listen: false)
                                      .executeOnlyIfSessionHasTimeLeft(context,
                                          () {
                                    ThemeProvider.controllerOf(context)
                                        .setTheme('classiclight');
                                    // print('change theme');
                                  });
                                  setState(
                                      () => selectedButton = 'classiclight');
                                },
                                splashColor: selectedButton == 'classiclight'
                                    ? Colors.black
                                    : Colors.black12,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: 120,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    // *** BUILD A LIST OF CUSTOM THEMES FOR SELECTION
                    ...MyThemes.all
                        .map((e) => Column(
                              children: [
                                ThemeOptionTile(
                                    themeContext: themeContext,
                                    themeTitle: e['themeName'],
                                    currentlySelectedTheme: (selectedButton ==
                                                e['lightThemeId'] ||
                                            selectedButton == e['darkThemeId'])
                                        ? true
                                        : false, // this is hardcoded for quick visual test
                                    btnColorLightTheme:
                                        selectedButton == e['lightThemeId']
                                            ? e['primaryColor']
                                            : Colors.white,
                                    btnColorDarkTheme:
                                        selectedButton == e['darkThemeId']
                                            ? e['primaryColor']
                                            : Colors.white,
                                    lightThemeHandler: () {
                                      Provider.of<Auth>(context, listen: false)
                                          .executeOnlyIfSessionHasTimeLeft(
                                              context,
                                              () => _newThemeSelected(context,
                                                  prefs: prefs,
                                                  bottomSheetVisible:
                                                      _bottomSheetVisible,
                                                  themeName: e['themeName'],
                                                  themePurchasedId:
                                                      e['themePurchaseId'],
                                                  specificThemeId:
                                                      e['lightThemeId']));
                                      setState(() =>
                                          selectedButton = e['lightThemeId']);
                                    },
                                    darkThemeHandler: () {
                                      Provider.of<Auth>(context, listen: false)
                                          .executeOnlyIfSessionHasTimeLeft(
                                              context,
                                              () => _newThemeSelected(context,
                                                  prefs: prefs,
                                                  bottomSheetVisible:
                                                      _bottomSheetVisible,
                                                  themeName: e['themeName'],
                                                  themePurchasedId:
                                                      e['themePurchaseId'],
                                                  specificThemeId:
                                                      e['darkThemeId']));
                                      setState(() =>
                                          selectedButton = e['darkThemeId']);
                                    }),
                                Divider()
                              ],
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _newThemeSelected(BuildContext context,
      {bool bottomSheetVisible = false,
      String themeName,
      String themePurchasedId,
      String specificThemeId,
      SharedPreferences prefs}) {
    String _purchased = prefs.getString(themePurchasedId);
    String _premium = prefs.getString('gs_3999_1y_1m0');
    String _pro = prefs.getString('gs_599_1m_1m0');
    String _tempPro = prefs.getString('proAccessPassword');
    bool _available = (_purchased != null && _purchased != '') ||
        (_premium != null && _premium != '') ||
        (_tempPro != null && _tempPro != '') ||
        (_pro != null && _pro != '');

    if (!bottomSheetVisible && !_available) {
      buildShowThemeScreenModalSheet(
              deviceData: prefs,
              context: context,
              specificSelectedThemeId: specificThemeId,
              themeName: themeName,
              // themePurchaseId: themePurchasedId,
              available: _available)
          .then((value) {
        _toggleBottomSheetVisibility();
      });
      _toggleBottomSheetVisibility();
    }
    ThemeProvider.controllerOf(context).setTheme(specificThemeId);
  }
}
