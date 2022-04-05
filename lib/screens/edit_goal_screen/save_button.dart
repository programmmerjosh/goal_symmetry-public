import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../widgets/inkWellButton.dart';

class SaveButton extends StatelessWidget {
  final Function _btnHandler;

  SaveButton(this._btnHandler);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWellButton(
          handler: _btnHandler,
          title: 'Save Changes',
          buttonWidth: 200,
          textStyle: ktsPrimaryWhite,
          backgroundColor: Theme.of(context).primaryColor,
          buttonBorderColor: Colors.white,
          leadingIcon: Icons.save,
        )
      ],
    );
  }
}
