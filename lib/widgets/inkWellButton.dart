import 'package:flutter/material.dart';
import '../custom_styles/custom_text_styles.dart';

class InkWellButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final Widget trailingWidget;
  final Color backgroundColor;
  final String title;
  final TextStyle textStyle;
  final Function handler;
  final Color splashColor;
  final Color buttonBorderColor;
  final double buttonBorderWidth;
  final TextAlign buttonTextAlign;
  final BoxFit boxFitText;
  const InkWellButton({
    this.backgroundColor = Colors.white,
    this.buttonHeight = 60,
    this.buttonWidth,
    @required this.handler,
    this.boxFitText = BoxFit.none,
    this.leadingIcon,
    this.splashColor,
    this.textStyle = ktsPrimaryWhite,
    @required this.title,
    this.trailingIcon,
    this.trailingWidget,
    this.buttonBorderColor = Colors.transparent,
    this.buttonBorderWidth = 4.0,
    this.buttonTextAlign = TextAlign.center,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
              color: buttonBorderColor,
              style: BorderStyle.solid,
              width: buttonBorderWidth),
          borderRadius: BorderRadius.circular(10)),
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
            child: FittedBox(
              alignment: buttonTextAlign == TextAlign.left
                  ? Alignment.centerLeft
                  : buttonTextAlign == TextAlign.right
                      ? Alignment.centerRight
                      : Alignment.center,
              fit: boxFitText,
              child: Row(
                mainAxisAlignment: buttonTextAlign == TextAlign.left
                    ? MainAxisAlignment.start
                    : buttonTextAlign == TextAlign.right
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  if (leadingIcon != null)
                    Icon(
                      leadingIcon,
                      color: textStyle.color,
                    ),
                  if (leadingIcon != null)
                    SizedBox(
                      width: 6,
                    ),
                  Text(
                    title,
                    style: textStyle,
                  ),
                  if (trailingIcon != null || trailingWidget != null)
                    SizedBox(
                      width: 6,
                    ),
                  if (trailingIcon != null)
                    Icon(
                      trailingIcon,
                      color: textStyle.color,
                    ),
                  if (trailingWidget != null) trailingWidget,
                  SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
            onTap: handler,
            splashColor: splashColor == null
                ? textStyle.color == Colors.white
                    ? Colors.black
                    : Theme.of(context).primaryColor
                : splashColor),
      ),
    );
  }
}
