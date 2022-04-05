import 'package:flutter/material.dart';

// import '../../custom_styles/custom_colors.dart';
import '../../custom_styles/custom_text_styles.dart';

class GoalTypeItem extends StatelessWidget {
  final String _typeName;
  final String _imageUrl;
  // final bool _wallAccess;
  final Function _tapHandler;
  final int _numOfGoalsInCategory;
  final GlobalObjectKey _key;

  GoalTypeItem(
      this._typeName,
      this._imageUrl,
      // this._wallAccess,
      this._tapHandler,
      this._numOfGoalsInCategory,
      this._key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _tapHandler,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // backgroundBlendMode: BlendMode.hardLight,
                // color: Colors.green,
                // color: Colors.white54,
              ),
              width: 150,
              height: 120,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  // *** ROUNDED SQUARE WITH BG IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      color:
                          // !_wallAccess ? Colors.red[900] :
                          Colors.transparent,
                      colorBlendMode:
                          // !_wallAccess ? BlendMode.softLight :
                          BlendMode.dst,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/$_imageUrl'),
                      // color: Color.fromRGBO(12, 12, 12, 0.2),
                    ),
                  ),
                  // *** DULL IMAGE OVERLAY FOR UNAVAILABLE CATEGORIES
                  // if (_accessLevel == null || _accessLevel == 'premium')
                  //   ClipRRect(
                  //       borderRadius: BorderRadius.circular(12),
                  //       child: Container(
                  //         color: Color.fromRGBO(255, 255, 255, 0.7),
                  //       )),
                  if (_numOfGoalsInCategory > 0)
                    // *** BUILD NUMBER OF GOALS WIDGET IN CATEGORY
                    Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black,
                          child: Center(
                            child: Text('$_numOfGoalsInCategory',
                                style: ktsGoalTypeItem.copyWith(
                                    color: Colors.white, fontSize: 13)),
                          ),
                        )),
                  // if (!_wallAccess)
                  // *** BUILD NUMBER OF GOALS WIDGET IN CATEGORY
                  // Positioned(
                  //   top: 0,
                  //   left: 0,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         width: 40,
                  //         height: 20,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           color: kTiffanyBlue,
                  //         ),
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(12),
                  //           child: Center(
                  //             child: Text(
                  //               'Pro',
                  //               textAlign: TextAlign.center,
                  //               style: ktsGoalTypeItem.copyWith(
                  //                   color: Colors.white, fontSize: 11),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         width: 60,
                  //         height: 20,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           color: kOrangeRedCrayola,
                  //         ),
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(12),
                  //           child: Center(
                  //             child: Text(
                  //               'Premium',
                  //               textAlign: TextAlign.center,
                  //               style: ktsGoalTypeItem.copyWith(
                  //                   color: Colors.white, fontSize: 11),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              )),
          // *** CATEGORY TITLE WITHIN A BLACK OVERLAY BOX
          Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black45,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      _typeName == 'Family/Relationships'
                          ? 'Family/\nRelationships'
                          : _typeName == 'Health/Fitness'
                              ? 'Health/\nFitness'
                              : _typeName,
                      textAlign: TextAlign.center,
                      style: ktsGoalTypeItem.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
