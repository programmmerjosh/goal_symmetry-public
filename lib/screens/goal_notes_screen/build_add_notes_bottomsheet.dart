// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';
import '../../widgets/inkWellButton.dart';

Future buildAddNotesBottomSheet(
    BuildContext context, String title, Function onAccept) {
  final _modalForm = GlobalKey<FormState>();
  bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape
      ? true
      : false;

  void _saveModalForm() {
    final isValid = _modalForm.currentState.validate();
    if (!isValid) {
      return;
    }
    _modalForm.currentState.save();
  }

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: isLandscape
              ? 0.9
              : 0.8, // this will adjust the bottom sheet height
          child: Container(
            color: Theme.of(context).disabledColor,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                      style: BorderStyle.solid),
                  color: Theme.of(context).hoverColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: isLandscape
                    ? const EdgeInsets.symmetric(horizontal: 40, vertical: 10)
                    : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  key: _modalForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add New Goal Note For: ',
                        style: Theme.of(context).backgroundColor == Colors.black
                            ? ktsGoalTypeItem.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.underline)
                            : ktsGoalTypeItem.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                decoration: TextDecoration.underline),
                      ),
                      Text('$title',
                          style:
                              Theme.of(context).backgroundColor == Colors.black
                                  ? ktsGoalTypeItem.copyWith(
                                      color: Colors.white, fontSize: 12)
                                  : ktsGoalTypeItem.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12)),
                      TextFormField(
                          style: ktsGoalLabel,
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 3,
                          textInputAction: TextInputAction.continueAction,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(labelText: 'Note'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Text cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (goalName) {
                            onAccept(goalName);
                            Navigator.of(context).pop();
                          }),
                      const Divider(),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWellButton(
                                handler: () => Navigator.of(context).pop(),
                                title: 'Cancel',
                                textStyle: ktsPrimaryWhite.copyWith(
                                    color: Theme.of(context).primaryColor),
                                backgroundColor: Colors.white,
                                buttonBorderColor:
                                    Theme.of(context).primaryColor,
                              ),
                            ),
                            Expanded(
                              child: InkWellButton(
                                handler: _saveModalForm,
                                title: 'Add',
                                textStyle: ktsPrimaryWhite,
                                backgroundColor: Theme.of(context).primaryColor,
                                buttonBorderColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
