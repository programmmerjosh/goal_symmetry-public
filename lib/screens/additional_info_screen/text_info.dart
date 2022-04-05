import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';

class TextInfo extends StatelessWidget {
  const TextInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        '1. Thank you for downloading Goal Symmetry!\n\n'
        '2. There are of course other goal setting apps '
        'out there, however this one is likely to exceed all your expectations '
        'and dare I say it, may even be the best one currently on the market.\n\n'
        '3. Any goals that you may add are stored on a Firebase server linked to your own '
        'personal username and password; therefore '
        'can be accessed via any device so long as you have the app installed, '
        'a stable internet connection and '
        'you have your username & password handy.\n\n'
        ''
        '4. If you come across any bugs/issues or features you\'d like '
        'us to fix or add respectively, '
        'please let us know within an app review. Also, when checking out the different themes, '
        'we\'d be very interested to know which of the themes are your favorite.\n\n'
        '5. Kindly note that this app does not and will not '
        'bombard you with ads at this time. '
        'You\'re welcome. We want you to enjoy this app without any annoyance or distraction. '
        'Also, if this app can serve '
        'you '
        'well and help '
        'you '
        'do well, then '
        'that\'s great. However, we encourage you to at least take a peak '
        'at the awesome themes available for purchase. The Pro (monthly) subscription  or '
        'Premium (annual) subscription would of course still be your best options as they give you full access to ALL '
        'the themes, features as well as the use of the Wall Of Achievements plus all the new app additions '
        'we may add in the future. But it\'s completely up to you.\n\n'
        '6. Thank you for all your support '
        'and kind reviews. Continue to be awesome! And happy goal achieving!',
        style: ktsGoalLabel);
  }
}
