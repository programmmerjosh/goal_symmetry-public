import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

import 'package:lottie/lottie.dart';

import './action_list_method.dart';

class AdaptiveUpdateDialog extends StatefulWidget {
  final String title;
  final String instructionMessage;
  final String placeholderText;
  final String textfieldText;
  final Function updateButtonPressed;
  final String customUpdateButtonText;
  final TextInputType textInputType;
  final int maxLines;

  AdaptiveUpdateDialog(
      {@required this.title,
      this.instructionMessage,
      this.customUpdateButtonText,
      this.textInputType = TextInputType.text,
      this.maxLines = 1,
      this.textfieldText = '',
      this.placeholderText = '',
      @required this.updateButtonPressed});

  @override
  _AdaptiveUpdateDialogState createState() => _AdaptiveUpdateDialogState();
}

class _AdaptiveUpdateDialogState extends State<AdaptiveUpdateDialog>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, value: 0, duration: Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    List<Widget> _actionList = buildCustomElevatedButtonForAdaptiveAlert(
      actionButton1Handler: () {
        if (!_formKey.currentState.validate()) {
          // Invalid!
          return;
        }
        _formKey.currentState.save();
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      },
      actionButton1Text: widget.customUpdateButtonText ?? 'Update',
      actionButton2Handler: null,
      actionButton2Text: null,
      dismissButtonText: 'Cancel',
      context: context,
    );
    return
        // Platform.isIOS
        //     ?
        Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 24.0, left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // animation
              Container(
                width: double.infinity,
                height: 100,
                child: Lottie.asset(
                  'assets/lottie_files/66615-wave-blue-lines.json',
                  width: 80,
                  height: 80,
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
              ),
              // title
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // text content
              if (widget.instructionMessage != null)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 24.0),
                  child: Text(
                    widget.instructionMessage,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              // placeholder text
              Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 24.0),
                  child: Form(
                    key: _formKey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Material(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: widget.placeholderText),
                              maxLines: widget.maxLines,
                              textCapitalization: TextCapitalization.sentences,
                              initialValue: widget.textfieldText,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Empty input not accepted';
                                }
                                return null;
                              },
                              // obscureText: true,
                              keyboardType: widget.textInputType,
                              onSaved: (value) =>
                                  widget.updateButtonPressed(value)),
                        ),
                      ),
                    ),
                  )),
              Row(children: _actionList)
            ],
          ),
        ),
      ),
    );
  }
}
