import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../../widgets/adaptive_app_bar.dart';
import '../../custom_styles/custom_box_decorations.dart';

class AttributionsScreen extends StatefulWidget {
  static const String routeName = '/attributions';
  const AttributionsScreen({Key key}) : super(key: key);

  @override
  _AttributionsScreenState createState() => _AttributionsScreenState();
}

class _AttributionsScreenState extends State<AttributionsScreen>
    with TickerProviderStateMixin {
  AnimationController _animatedController;

  static const List<Map<String, Object>> _attributionList = [
    // animations
    {
      'authorTitle': 'Q Donleavy',
      'productTitle': 'Wave Variant',
      'productType': 'animation',
      'productReference': '24989-wave-variant.json',
      'productDescription': 'Wave variant animation.',
      'url': 'https://lottiefiles.com/24989-wave-variant',
    },
    {
      'authorTitle': '#TeamIronMan',
      'productTitle': 'Wave Blue Lines',
      'productType': 'animation',
      'productReference': '66615-wave-blue-lines.json',
      'productDescription': 'Wave animation.',
      'url': 'https://lottiefiles.com/66615-wave-blue-lines',
    },
    {
      'authorTitle': 'Rafael Cordeiro',
      'productTitle': 'Done',
      'productType': 'animation',
      'productReference': '28702-done.json',
      'productDescription': 'Done animation.',
      'url': 'https://lottiefiles.com/28702-done',
    },
    // images
    {
      'authorTitle': 'Peggy und Marco Lachmann-Anke',
      'productTitle': 'question-mark',
      'productType': 'image',
      'productReference': 'question-1015308_1920-min.jpg',
      'productDescription': 'Question mark image.',
      'url':
          'https://pixabay.com/illustrations/question-question-mark-response-1015308/',
    },
    {
      'authorTitle': 'Pexels',
      'productTitle': 'agility-ballet',
      'productType': 'image',
      'productReference': 'agility-1850711_640-min.jpg',
      'productDescription': 'Ballet dancing image',
      'url':
          'https://pixabay.com/photos/agility-ballet-dancing-athlete-1850711/',
    },
    {
      'authorTitle': 'James Wheeler',
      'productTitle': 'alberta-canada',
      'productType': 'image',
      'productReference': 'alberta-2297204_640-min.jpg',
      'productDescription': 'Canada Mountains image',
      'url':
          'https://pixabay.com/photos/alberta-canada-lake-mountains-2297204/',
    },
    {
      'authorTitle': 'Steve Buissinne',
      'productTitle': 'credit-card',
      'productType': 'image',
      'productReference': 'credit-card-1520400_640-min.jpg',
      'productDescription': 'Credit Card image',
      'url':
          'https://pixabay.com/photos/credit-card-master-card-visa-card-1520400/',
    },
    {
      'authorTitle': 'A_Different_Perspective',
      'productTitle': 'aircraft-flying',
      'productType': 'image',
      'productReference': 'extra-300-2666539_640-min.jpg',
      'productDescription': 'Small flying aircraft image',
      'url':
          'https://pixabay.com/photos/extra-300-aircraft-flying-flugshow-2666539/',
    },
    {
      'authorTitle': 'Stephanie Pratt',
      'productTitle': 'family-newborn',
      'productType': 'image',
      'productReference': 'family-2610205_640-min.jpg',
      'productDescription': 'Family image',
      'url':
          'https://pixabay.com/photos/family-newborn-baby-child-infant-2610205/',
    },
    {
      'authorTitle': 'Toby Parsons',
      'productTitle': 'ferrari-458-spider',
      'productType': 'image',
      'productReference': 'ferrari-458-spider-2932191_640-min.jpg',
      'productDescription': 'Ferrari Spider image',
      'url':
          'https://pixabay.com/photos/ferrari-458-spider-ferrari-458-2932191/',
    },
    {
      'authorTitle': 'QuinceCreative',
      'productTitle': 'arrow-target-bullseye',
      'productType': 'image',
      'productReference': 'arrow-2886223_640-min.jpg',
      'productDescription': 'Target image',
      'url':
          'https://pixabay.com/photos/arrow-target-bullseye-goal-aim-2886223/',
    },
    {
      'authorTitle': 'Dariusz Sankowski',
      'productTitle': 'glasses-book-education',
      'productType': 'image',
      'productReference': 'knowledge-1052010_640-min.jpg',
      'productDescription': 'Book and glasses image',
      'url':
          'https://pixabay.com/photos/glasses-book-education-eyeglasses-1052010/',
    },
    {
      'authorTitle': 'Gerd Altmann',
      'productTitle': 'learn-school-student',
      'productType': 'image',
      'productReference': 'learn-1996845_640-min.jpg',
      'productDescription': 'Self study image',
      'url':
          'https://pixabay.com/photos/learn-school-student-mathematics-1996845/',
    },
    {
      'authorTitle': 'Foundry',
      'productTitle': 'life-beauty',
      'productType': 'image',
      'productReference': 'life-862985_640-min.jpg',
      'productDescription': 'Motivation image',
      'url': 'https://pixabay.com/photos/life-beauty-scene-achieve-862985/',
    },
    {
      'authorTitle': 'Free-Photos',
      'productTitle': 'office-business',
      'productType': 'image',
      'productReference': 'office-1209640_640-min.jpg',
      'productDescription': 'Office work image',
      'url':
          'https://pixabay.com/photos/office-business-men-businessmen-1209640/',
    },
    {
      'authorTitle': 'AndiP',
      'productTitle': 'yoga-asana-pose',
      'productType': 'image',
      'productReference': 'yoga-2959226_640-min.jpg',
      'productDescription': 'Yoga image',
      'url':
          'https://pixabay.com/photos/yoga-asana-pose-hatha-woman-girl-2959226/',
    },
    {
      'authorTitle': 'oNline Web Fonts',
      'productTitle': 'TT Interphases Var Roman',
      'productType': 'Font',
      'productReference': 'TT-interphases-var-roman-min.png',
      'productDescription': 'Font',
      'url': 'http://www.onlinewebfonts.com',
    },
    {
      'authorTitle': 'Sebastian Emir Llapur Gandulfo',
      'productTitle': 'Cosmos-Cursor',
      'productType': 'Mousecape',
      'productReference': 'mousecape-screenshot-min.png',
      'productDescription': 'Mousecape used in tutorial gif\'s',
      'url': 'https://www.deviantart.com/sllapur/art/Cosmos-Cursor-722995505',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
        vsync: this, value: 0, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;

    return Scaffold(
      appBar: buildAdaptiveAppBar(context, 'Attributions', null, null),
      body: Container(
        // height: double.infinity,
        decoration: scaffoldBodyBoxDecoration(context),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _attributionList.length,
                  itemBuilder: (ctx, i) => Padding(
                        padding: isLandscape
                            ? const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40)
                            : const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          children: [
                            // AUTHOR
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text('Author:'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    // width: 150,
                                    child: Text(
                                        '${_attributionList[i]['authorTitle']}'),
                                  ),
                                ],
                              ),
                            ),
                            // PRODUCT NAME
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text('Product:'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    // width: 150,
                                    child: Text(
                                        '${_attributionList[i]['productTitle']}'),
                                  ),
                                ],
                              ),
                            ),
                            // PRODUCT DESCRIPTION
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text('Description:'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    // width: 150,
                                    child: Text(
                                        '${_attributionList[i]['productDescription']}'),
                                  ),
                                ],
                              ),
                            ),
                            // URL
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text('URL:'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      '${_attributionList[i]['url']}',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                          onExpansionChanged: (val) {},
                          title: Text('${_attributionList[i]['productTitle']}'),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _attributionList[i]['productReference']
                                        .toString()
                                        .substring(_attributionList[i]
                                                    ['productReference']
                                                .toString()
                                                .length -
                                            5) ==
                                    '.json'
                                ? Lottie.asset(
                                    'assets/lottie_files/${_attributionList[i]['productReference']}',
                                    width: 60,
                                    height: 60,
                                    controller: _animatedController,
                                    onLoaded: (composition) {
                                      _animatedController
                                        ..duration = composition.duration;
                                      _animatedController.repeat();
                                    },
                                  )
                                : Container(
                                    height: 60,
                                    width: 60,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/${_attributionList[i]['productReference']}'),
                                      // color: Color.fromRGBO(12, 12, 12, 0.2),
                                    ),
                                  ),
                          ),
                          subtitle:
                              Text('${_attributionList[i]['productType']}'),
                          trailing: Icon(Icons.arrow_downward),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
