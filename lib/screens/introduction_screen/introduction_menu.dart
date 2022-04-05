import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/adaptive_app_bar.dart';
import '../../widgets/adaptiveAlertDialog.dart';
import '../../custom_styles/custom_colors.dart';
import '../../custom_styles/custom_text_styles.dart';
import '../overview_page.dart';
import './introduction_screen.dart';
import '../../widgets/inkWellButton.dart';

class IntroMenuScreen extends StatefulWidget {
  static const routeName = '/intro-menu';
  IntroMenuScreen({Key key}) : super(key: key);

  @override
  _IntroMenuScreenState createState() => _IntroMenuScreenState();
}

class _IntroMenuScreenState extends State<IntroMenuScreen> {
  bool _wallAccess = false;
  bool _tempProAccess = false;
  bool _hasLoaded = false;

  void _checkUserAccess(SharedPreferences prefs) {
    bool a, b;

    try {
      a = OverviewPage.premiumOrProAccess(prefs);
      b = OverviewPage.tempProAccess(prefs);
    } catch (error) {
    } finally {
      if (mounted) {
        setState(() {
          _wallAccess = a;
          _tempProAccess = b;
          _hasLoaded = true;
        });
      }
    }
  }

  @override
  void didChangeDependencies() async {
    if (!_hasLoaded) {
      final prefs = await SharedPreferences.getInstance();
      _checkUserAccess(prefs);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAdaptiveAppBar(context, 'App Tutorials', null, null),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: [
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Navigate Around',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Add A Goal',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Delete A Goal',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Reorder A Goal List',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Add A Milestone',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Update A Milestone',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Delete A Milestone',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Review And Track A Goal',
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Add A Note',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Update A Note',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Delete A Note',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Send To Wall Of Achievements',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Filter Achievements By Date',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Filter Achievements By Division',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 4,
              ),
              BuildTutorialButton(
                mapKey: 'Multiple Filters For Achievements',
                grantAccess: _tempProAccess || _wallAccess,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTutorialButton extends StatelessWidget {
  final String title;
  final String mapKey;
  final bool grantAccess;
  final Function onPressed;

  BuildTutorialButton({
    this.title,
    @required this.mapKey,
    this.grantAccess = true,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape
    //         ? true
    //         : false;

    return InkWellButton(
      buttonWidth: double.infinity,
      splashColor: Colors.black12,
      handler: grantAccess
          ?
          // onPressed

          () => Navigator.of(context)
              .pushNamed(IntroScreen.routeName, arguments: [mapKey])
          : () {
              return showDialog(
                  context: context,
                  builder: (ctx) => AdaptiveAlertDialog(
                        title: 'Not Pro OR Premium',
                        contentText: 'You do not currently have the Pro or '
                            'Premium subscription and therefore do '
                            'not need to view this tutorial.',
                      ));
            },
      title: title ?? '$mapKey',
      textStyle: ktsPrimaryWhite.copyWith(
          color: Theme.of(context).primaryColor, fontSize: 16),
      backgroundColor: Colors.white,
      buttonBorderColor: Theme.of(context).primaryColor,
      trailingWidget: !grantAccess
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Pro / Premium',
                      style: ktsPrimaryWhite.copyWith(
                          fontSize: 9, fontWeight: FontWeight.bold)),
                ),
                color: kOrangeRedCrayola,
              ),
            )
          : null,
    );
  }
}
