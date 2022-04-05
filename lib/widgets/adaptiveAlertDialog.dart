import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

import 'package:lottie/lottie.dart';

import './action_list_method.dart';

class AdaptiveAlertDialog extends StatefulWidget {
  final String title;
  final String contentText;
  final String dismissButtonText;
  final String actionButton1Text;
  final Function actionButton1Handler;
  final String actionButton2Text;
  final Function actionButton2Handler;

  AdaptiveAlertDialog(
      {@required this.title,
      @required this.contentText,
      this.dismissButtonText,
      this.actionButton1Text,
      this.actionButton1Handler,
      this.actionButton2Text,
      this.actionButton2Handler});

  @override
  _AdaptiveAlertDialogState createState() => _AdaptiveAlertDialogState();
}

class _AdaptiveAlertDialogState extends State<AdaptiveAlertDialog>
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
    List<Widget> _actionList = buildCustomElevatedButtonForAdaptiveAlert(
        actionButton1Handler: widget.actionButton1Handler,
        actionButton1Text: widget.actionButton1Text,
        actionButton2Handler: widget.actionButton2Handler,
        actionButton2Text: widget.actionButton2Text,
        context: context,
        dismissButtonText: widget.dismissButtonText);
    return
        // Platform.isIOS
        //     ?
        // https://assets9.lottiefiles.com/packages/lf20_ao9FbT.json
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
                  'assets/lottie_files/24989-wave-variant.json',
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 24.0),
                child: Text(
                  widget.contentText,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(children: _actionList)
            ],
          ),
        ),
      ),
    );
  }
}
