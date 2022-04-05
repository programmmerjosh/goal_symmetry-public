import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/adaptiveAlertDialog.dart';

void buildRatingPrompt(BuildContext context, RateMyApp rateMyApp) {
  // => uncomment below line FOR testing
  if (rateMyApp.shouldOpenDialog) {
    rateMyApp.showStarRateDialog(context,
        title: 'Rate This App!', message: 'Would you rate this app 5 stars?',
        actionsBuilder: (ctx, stars) {
      // Triggered when the user updates the star rating.
      return [
        // Return a list of actions (that will be shown at the bottom of the dialog).
        TextButton(
          child: Text('OK'),
          onPressed: () {
            if (stars != null) {
              rateMyApp.save().then((value) {
                rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                Navigator.pop<RateMyAppDialogButton>(
                    context, RateMyAppDialogButton.rate);

                if (stars <= 3) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AdaptiveAlertDialog(
                            title: 'Only ${stars.round()} stars?',
                            contentText:
                                'Sorry this app has not met your expectation/standards. '
                                'The developer is always trying to improve upon user '
                                'experience and performance. Hope you like the next '
                                'version.',
                          ));
                } else if (stars >= 4) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AdaptiveAlertDialog(
                            title: 'Thank You!',
                            contentText:
                                'Glad you like this app! If you\'d be so kind, '
                                'would you please leave a review on the '
                                '${Platform.isIOS ? 'App' : 'Play'} Store',
                            dismissButtonText: 'No',
                            actionButton1Text: 'Okay',
                            actionButton1Handler: () async {
                              Navigator.of(context).pop();
                              // TODO: AFTER PRODUCTION - these links need testing when apps are LIVE
                              const iOS_url =
                                  'itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1538288839&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software';
                              const android_url =
                                  'http://play.google.com/store/apps/details?id=com.programmmerjosh.goal_symmetry';
                              var url = Platform.isIOS ? iOS_url : android_url;
                              await canLaunch(url).then((success) async {
                                if (success) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              });

                              // links found on Google
                              // iOS link?? itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=YOUR_APP_ID&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software
                              // Android link?? "http://play.google.com/store/apps/details?id=$packageName"
                            },
                          ));
                }
              });
            }
          },
        ),
      ];
    },
        dialogStyle: DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.only(bottom: 20.0),
        ),
        starRatingOptions: StarRatingOptions());
  }
}
