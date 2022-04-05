import 'package:flutter/material.dart';

class ScreenImage extends StatelessWidget {
  final Function onPressed;
  final String imageReference;
  const ScreenImage(
      {@required this.onPressed, @required this.imageReference, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(imageReference),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/gifs/$imageReference',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('TAP IMAGE TO ZOOM OUT',
                                  style: TextStyle(
                                      color: Colors.amber[700],
                                      fontSize: 21,
                                      decoration: TextDecoration.none)),
                            ])
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
