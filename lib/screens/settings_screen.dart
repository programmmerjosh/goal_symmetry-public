import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../custom_styles/custom_box_decorations.dart';
import '../custom_styles/custom_text_styles.dart';
import '../screens/tabs_screen/test_theme_purchased_method.dart';
import '../helpers/db_helper.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, Object>> _progressManagementRadioOptions = [
    {'option': 'Individual Management', 'value': 'default'},
    {'option': 'Manage All By Progress Bar Percentage', 'value': ''},
    {'option': 'Manage All By Completed Milestones', 'value': ''},
  ];

  List<Map<String, Object>> _autoLoginRadioOptions = [
    {
      'option':
          'Yes. Save My App-Login-Credentials To This Device And Login Automatically When I Open The App',
      'value': 'default'
    },
    {'option': 'No. I Prefer To Login Manually', 'value': ''},
  ];
  bool loaded = false;
  String _chosenProgressManagementOption;
  String _chosenAutoLoginOption;

  Future<void> _updateProgressManagementOption(String selectedOption) async {
    DeviceKeyValuePairs.save('overrideGoalProgressManagement', selectedOption);

    setState(() {
      for (var i = 0; i < _progressManagementRadioOptions.length; i++) {
        if (_progressManagementRadioOptions[i]['option'] != selectedOption) {
          _progressManagementRadioOptions[i]['value'] = '';
        } else {
          _progressManagementRadioOptions[i]['value'] = selectedOption;
        }
      }
    });
  }

  Future<void> _updateAutoLoginOption(String selectedOption) async {
    DeviceKeyValuePairs.save('alwaysAutoLogin', selectedOption);

    setState(() {
      for (var i = 0; i < _autoLoginRadioOptions.length; i++) {
        if (_autoLoginRadioOptions[i]['option'] != selectedOption) {
          _autoLoginRadioOptions[i]['value'] = '';
        } else {
          _autoLoginRadioOptions[i]['value'] = selectedOption;
        }
      }
    });
  }

  void getChosenOptions(SharedPreferences deviceData) {
    String chosenProgressManagementOption;
    String chosenAutoLoginOption;

    try {
      // final prefs = await SharedPreferences.getInstance();
      chosenAutoLoginOption = deviceData.getString('alwaysAutoLogin');
      chosenProgressManagementOption =
          deviceData.getString('overrideGoalProgressManagement');
    } catch (error) {
      print('setState error');
    } finally {
      setState(() {
        _chosenProgressManagementOption = chosenProgressManagementOption;
        _chosenAutoLoginOption = chosenAutoLoginOption;
      });
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!loaded && mounted) {
      final prefs = await SharedPreferences.getInstance();
      try {
        testTheme(context, prefs);
        getChosenOptions(prefs);
      } catch (error) {
        print('error in didChangeDependencies');
      } finally {
        if (_chosenProgressManagementOption == null ||
            _chosenProgressManagementOption == '') {
          _progressManagementRadioOptions[0]['value'] =
              _progressManagementRadioOptions[0]['option'];
        } else {
          _updateProgressManagementOption(_chosenProgressManagementOption);
        }

        if (_chosenAutoLoginOption == null || _chosenAutoLoginOption == '') {
          _autoLoginRadioOptions[0]['value'] =
              _autoLoginRadioOptions[0]['option'];
        } else {
          _updateAutoLoginOption(_chosenAutoLoginOption);
        }
      }
      setState(() => loaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "App Settings",
          style: ktsNavbarTitle,
        ),
      ),
      body: !loaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              decoration: scaffoldBodyBoxDecoration(context),
              // decoration: textBlockBoxDecoration(context).copyWith(
              //     color: Theme.of(context).primaryColor.withOpacity(0.3)),
              child: Padding(
                padding: isLandscape
                    ? const EdgeInsets.symmetric(vertical: 10, horizontal: 40)
                    : const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Goal Progress Management',
                        style: ktsGoalTypeItem,
                      ),
                      ..._progressManagementRadioOptions
                          .map((e) => Column(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                          width: 120,
                                          child: Text(
                                            e['option'],
                                            style: ktsGoalLabel,
                                          )),
                                    ),
                                    Radio(
                                      value: e['option'],
                                      groupValue: e['value'],
                                      onChanged: (_) =>
                                          _updateProgressManagementOption(
                                              e['option']),
                                    )
                                  ]),
                                  const Divider(),
                                ],
                              ))
                          .toList(),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'Auto-login On This Device',
                            style: ktsGoalTypeItem,
                          ),
                          ..._autoLoginRadioOptions.map((el) => Column(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                          width: 120,
                                          child: Text(
                                            el['option'],
                                            style: ktsGoalLabel,
                                          )),
                                    ),
                                    Radio(
                                      value: el['option'],
                                      groupValue: el['value'],
                                      onChanged: (_) =>
                                          _updateAutoLoginOption(el['option']),
                                    )
                                  ]),
                                  const Divider(),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
