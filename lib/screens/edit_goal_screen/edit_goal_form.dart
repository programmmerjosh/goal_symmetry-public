import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';

class EditGoalForm extends StatelessWidget {
  final String _title;
  final GlobalKey _form;
  final Function _save;

  EditGoalForm(this._title, this._form, this._save);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: TextFormField(
          initialValue: _title,
          textCapitalization: TextCapitalization.sentences,
          style: ktsGoalLabel,
          decoration: const InputDecoration(labelText: 'Edit Your Goal Here:'),
          textInputAction: TextInputAction.done,
          maxLines: 3,
          onFieldSubmitted: (_) {},
          onSaved: (value) {
            _save(value);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Insert your goal here';
            }
            // return value;
            return null;
          },
        ));
  }
}
