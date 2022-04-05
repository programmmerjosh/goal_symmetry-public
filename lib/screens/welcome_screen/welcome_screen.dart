import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/db_helper.dart';
import '../../custom_styles/custom_box_decorations.dart';
import '../additional_info_screen/additional_info_screen.dart';
import '../tabs_screen/test_theme_purchased_method.dart';
import './top_right_corner_button.dart';
import './animated_heading.dart';
import './welcome_message.dart';
import './quote_section.dart';
import './continue_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _checked = false;
  bool _hasLoaded = false;

  void _testForCheckboxCheck() {
    if (_checked) {
      DeviceKeyValuePairs.save('hideWelcomeScreenOnLoad', 'hide');
    }
  }

  void _toggleCheck(bool value) {
    setState(() {
      _checked = value;
    });
  }

  @override
  void didChangeDependencies() async {
    if (!_hasLoaded && mounted) {
      final prefs = await SharedPreferences.getInstance();

      // set auto-login to true
      if (prefs.getString('alwaysAutoLogin') == null)
        prefs.setString('alwaysAutoLogin',
            'Yes. Save My App-Login-Credentials To This Device And Login Automatically When I Open The App');

      testTheme(context, prefs);
      setState(() => _hasLoaded = true);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;
    double listViewContainerHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: scaffoldBodyBoxDecoration(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // *** INFO BUTTON
                TopRightCornerButton(
                  title: 'Info',
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AdditionalInfoScreen.routeName),
                ),
                // THE REST OF THE PAGE WITHIN A SCROLL VIEW
                Container(
                  height: isLandscape
                      ? listViewContainerHeight * 0.75
                      : listViewContainerHeight * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // *** GOAL SYMMETRY ANIMATED HEADING
                        AnimatedHeading(),
                        // *** WELCOME MESSAGE
                        WelcomeMessage(),
                        const SizedBox(
                          height: 10,
                        ),
                        // *** Ralph Waldo Emerson QUOTE SECTION
                        QuoteSection(),
                        const SizedBox(
                          height: 10,
                        ),
                        // *** RIGHT ALIGNED CONTINUE BUTTON
                        ContinueButton(_testForCheckboxCheck),
                        // DON'T SHOW WELCOME SCREEN CHECKBOX
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Don\'t show this screen again '),
                            Checkbox(
                              value: _checked,
                              onChanged: (value) => _toggleCheck(value),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
