import 'package:flutter/material.dart';

import '../custom_styles/custom_text_styles.dart';

enum NavBarRightButtonIcon { Add, Filters }

PreferredSizeWidget buildAdaptiveAppBar(BuildContext context, String title,
    NavBarRightButtonIcon btnIcon, Function btnHandler,
    {GlobalObjectKey addGoalKey}) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: TextButton(
      onPressed: () => Navigator.pop(context),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: ktsNavbarTitle,
        ),
      ),
    ),
    actions: [
      btnIcon != null
          ? IconButton(
              color: Colors.white,
              icon: btnIcon == NavBarRightButtonIcon.Add
                  ? Icon(
                      Icons.add,
                      key: addGoalKey,
                    )
                  : FittedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.tune,
                          ),
                          const Text('Filters')
                        ],
                      ),
                    ),
              onPressed: btnHandler,
            )
          : const Text(''),
    ],
  );
}
