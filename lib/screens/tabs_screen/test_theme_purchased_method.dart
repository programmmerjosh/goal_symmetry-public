import 'package:flutter/material.dart';

import 'package:theme_provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/app_theme_data.dart';
import '../../screens/overview_page.dart';
import '../../new_providers/auth.dart';

void testTheme(BuildContext context, SharedPreferences deviceData) {
  final bool _wallAccess = OverviewPage.premiumOrProAccess(deviceData);
  final bool _tempProAccess = OverviewPage.tempProAccess(deviceData);

  try {
    String currentUserSelectedThemeId = ThemeProvider.themeOf(context).id;
    String purchasedThemeId = getThemePurchasedId(currentUserSelectedThemeId);

    String themeName = getThemeName(currentUserSelectedThemeId);

    bool _selectedThemeAvailable =
        (deviceData.getString(purchasedThemeId) != null &&
                deviceData.getString(purchasedThemeId) != '') ||
            _wallAccess ||
            _tempProAccess;

    String previouslySavedThemeId =
        deviceData.getString('previouslySavedThemeId');

    // uncomment below line for testing the theme purchased check
    // _selectedThemeAvailable = true;

    if (currentUserSelectedThemeId != 'stockstandardlight' &&
        currentUserSelectedThemeId != previouslySavedThemeId &&
        !_selectedThemeAvailable) {
      if (previouslySavedThemeId != null && previouslySavedThemeId != '') {
        ThemeProvider.controllerOf(context).setTheme(previouslySavedThemeId);
      } else {
        ThemeProvider.controllerOf(context).setTheme('stockstandardlight');
      }
      Auth.showSessionRelatedSimpleNotification(
          message:
              'You\'ll need to purchase \'${themeName.replaceAll('\n', ' ')}\' theme, \'Pro\' or \'Premium\' subscription to enjoy the use of this theme.',
          secondsToBeDisplayed: 6);
    }
  } catch (e) {
    // print('theme access test error: $e');
  }
}

String getThemePurchasedId(String themeId) {
  return MyThemes.all.firstWhere((element) =>
      element['lightThemeId'] == themeId ||
      element['darkThemeId'] == themeId)['themePurchaseId'];
}

String getThemeAvailableLightId(String themePurchasedId) {
  try {
    return MyThemes.all.firstWhere((element) =>
        element['themePurchaseId'] == themePurchasedId)['lightThemeId'];
  } catch (e) {
    return null;
  }
}

String getThemeAvailableDarkId(String themePurchasedId) {
  try {
    return MyThemes.all.firstWhere((element) =>
        element['themePurchaseId'] == themePurchasedId)['darkThemeId'];
  } catch (e) {
    return null;
  }
}

String getThemeName(String themeId) {
  try {
    return MyThemes.all.firstWhere((element) =>
        element['lightThemeId'] == themeId ||
        element['darkThemeId'] == themeId)['themeName'];
  } catch (e) {
    return null;
  }
}
