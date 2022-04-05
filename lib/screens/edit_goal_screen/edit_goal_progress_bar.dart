import 'package:flutter/material.dart';

import '../../custom_styles/custom_text_styles.dart';

class EditGoalProgressBar extends StatelessWidget {
  final int _progress;
  final Function _btnHandler;
  EditGoalProgressBar(this._progress, this._btnHandler);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;
    return Container(
      height: isLandscape ? 90 : 140,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: Text(
              'Goal Progress:',
              style: isLandscape
                  ? ktsGoalLabel.copyWith(fontSize: 14)
                  : ktsGoalLabel,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  _progress.toString(),
                  style: isLandscape
                      ? ktsProgressNumber.copyWith(fontSize: 28)
                      : ktsProgressNumber,
                ),
              ),
              const Text(
                '%',
                style: ktsGoalLabel,
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              inactiveTrackColor: const Color(0xFF8D8E98),
              activeTrackColor: Colors.amber,
              thumbColor: const Color(0xFFEB1555),
              overlayColor: const Color(0x29EB1555),
              thumbShape: isLandscape
                  ? RoundSliderThumbShape(enabledThumbRadius: 10.0)
                  : RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: isLandscape
                  ? RoundSliderOverlayShape(overlayRadius: 15.0)
                  : RoundSliderOverlayShape(overlayRadius: 25.0),
            ),
            child: Slider(
              value: _progress.toDouble(),
              min: 0.0,
              max: 100.0,
              onChanged: (double newValue) => _btnHandler(newValue.round()),
            ),
          )
        ],
      ),
    );
  }
}
