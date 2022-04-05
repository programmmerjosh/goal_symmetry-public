import 'package:flutter/material.dart';
import 'package:goal_symmetry/custom_styles/custom_colors.dart';

// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../custom_styles/custom_box_decorations.dart';
import '../../widgets/adaptive_app_bar.dart';
import '../../widgets/adaptive_update_dialog.dart';
import '../../widgets/custom_simple_snackbar.dart';
import '../../new_providers/auth.dart';
import '../attributions.dart';
import './text_info.dart';
import '../../widgets/inkWellButton.dart';

class AdditionalInfoScreen extends StatelessWidget {
  static const routeName = '/additional-info';

  Future<void> unlockProAccessUsingPassword(
      BuildContext context, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // TODO: CHANGE HACK PASSWORD IF NECESSARY
    // change temp pro access password here if necessary
    if (password == 'p@ssword!1') {
      String pap = prefs.getString('proAccessPassword');

      if (pap == null || pap == '') {
        prefs.setString('proAccessPassword', password);
        showCustomSimpleSnackbar(context, message: 'Pro Access Unlocked!');
      } else {
        prefs.remove('proAccessPassword');
        showCustomSimpleSnackbar(context, message: 'Pro Access Disabled!');
      }
    } else {
      Auth.showSessionRelatedSimpleNotification(message: 'Nope.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAdaptiveAppBar(context, 'Info', null, null),
      body: Container(
        height: double.infinity,
        decoration: scaffoldBodyBoxDecoration(context),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: textBlockBoxDecoration(context),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        const Text('Mission:', style: ktsGoalTypeItem),
                        const SizedBox(height: 10),
                        const Text(
                          'This app was created in hopes to encourage people to '
                          'set goals for themselves and to at some point discover '
                          'the value of having clearly defined and realistic goals '
                          'to pursue.\n',
                          style: ktsGoalLabel,
                        ),
                        const SizedBox(height: 10),
                        const Text('A few important notes:',
                            style: ktsGoalTypeItem),
                        const SizedBox(height: 10),
                        TextInfo(),
                      ],
                    ),
                  ),
                ),
                InkWellButton(
                  handler: () => Navigator.of(context)
                      .pushNamed(AttributionsScreen.routeName),
                  title: 'Attributions',
                  textStyle: ktsPrimaryWhite,
                  backgroundColor: kOrangeRedCrayola,
                  buttonBorderColor: Colors.white,
                  buttonWidth: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onLongPress: () => showDialog(
                        context: context,
                        builder: (context) => AdaptiveUpdateDialog(
                            title: 'Unlock Pro Access',
                            placeholderText: 'Secret Password',
                            textInputType: TextInputType.visiblePassword,
                            updateButtonPressed: (String password) async =>
                                unlockProAccessUsingPassword(
                                    context, password))),
                    child: InkWellButton(
                      handler: () => Navigator.of(context).pop(),
                      title: 'Go Back',
                      textStyle: ktsPrimaryWhite.copyWith(
                          color: Theme.of(context).primaryColor),
                      backgroundColor: Colors.white,
                      buttonBorderColor: Theme.of(context).primaryColor,
                      splashColor: Colors.black12,
                      buttonWidth: 170,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
