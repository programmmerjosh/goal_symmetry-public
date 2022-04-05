import 'package:intl/intl.dart';

class GoalData {
  static List<Map<String, Object>> divisionList = [
    {'divisionList': [], 'name': 'Dreams'},
    {'divisionList': [], 'name': 'Long Term Goals'},
    {'divisionList': [], 'name': 'Short Term Goals'},
  ];

  static List<Map<String, Object>> dreamList = [
    {
      'dreamList': [],
      'name': 'Experiences',
      'imageUrl': 'extra-300-2666539_640-min.jpg',
      'access': 'all'
    },
    {
      'dreamList': [],
      'name': 'Family/Relationships',
      'imageUrl': 'family-2610205_640-min.jpg',
      'access': 'all'
    },
    {
      'dreamList': [],
      'name': 'Achievements',
      'imageUrl': 'life-862985_640-min.jpg',
      'access': 'premium'
    },
    {
      'dreamList': [],
      'name': 'Destinations',
      'imageUrl': 'alberta-2297204_640-min.jpg',
      'access': 'premium'
    },
    {
      'dreamList': [],
      'name': 'Possessions',
      'imageUrl': 'ferrari-458-spider-2932191_640-min.jpg',
      'access': 'premium'
    },
  ];

  static List<Map<String, Object>> termList = [
    {
      'type': [],
      'name': 'Health/Fitness',
      'imageUrl': 'yoga-2959226_640-min.jpg',
      'access': 'all',
    },
    {
      'type': [],
      'name': 'Family/Relationships',
      'imageUrl': 'family-2610205_640-min.jpg',
      'access': 'all',
    },
    {
      'type': [],
      'name': 'Work',
      'imageUrl': 'office-1209640_640-min.jpg',
      'access': 'all',
    },
    {
      'type': [],
      'name': 'Experiences',
      'imageUrl': 'extra-300-2666539_640-min.jpg',
      'access': 'premium',
    },
    {
      'type': [],
      'name': 'Achievements',
      'imageUrl': 'life-862985_640-min.jpg',
      'access': 'premium',
    },
    {
      'type': [],
      'name': 'Financial',
      'imageUrl': 'credit-card-1520400_640-min.jpg',
      'access': 'premium',
    },
    {
      'type': [],
      'name': 'Education',
      'imageUrl': 'knowledge-1052010_640-min.jpg',
      'access': 'premium',
    },
    {
      'type': [],
      'name': 'Languages',
      'imageUrl': 'learn-1996845_640-min.jpg',
      'access': 'premium',
    },
    {
      'type': [],
      'name': 'Skills',
      'imageUrl': 'agility-1850711_640-min.jpg',
      'access': 'premium',
    },
  ];

  static List<Map<String, String>> typeOptions = [
    {'name': 'Financial', 'imageUrl': 'credit-card-1520400_640-min.jpg'},
    {'name': 'Achievements', 'imageUrl': 'life-862985_640-min.jpg'},
    {'name': 'Experiences', 'imageUrl': 'extra-300-2666539_640-min.jpg'},
    {'name': 'Family/Relationships', 'imageUrl': 'family-2610205_640-min.jpg'},
    {'name': 'Education', 'imageUrl': 'knowledge-1052010_640-min.jpg'},
    {'name': 'Languages', 'imageUrl': 'learn-1996845_640-min.jpg'},
    {'name': 'Skills', 'imageUrl': 'agility-1850711_640-min.jpg'},
    {'name': 'Work', 'imageUrl': 'office-1209640_640-min.jpg'},
    {
      'name': 'Possessions',
      'imageUrl': 'ferrari-458-spider-2932191_640-min.jpg'
    },
    {'name': 'Destinations', 'imageUrl': 'alberta-2297204_640-min.jpg'},
    {'name': 'Health/Fitness', 'imageUrl': 'yoga-2959226_640-min.jpg'}
  ];

  static int hoursBetween(DateTime date1, DateTime date2) {
    return date1.difference(date2).inHours;
  }

  static int minsBetween(DateTime date1, DateTime date2) {
    return date1.difference(date2).inMinutes;
  }

  static String dateToString(DateTime date) {
    return date.toString();
  }

  static String dateToFormattedString(DateTime date) {
    return DateFormat.yMMMd().add_Hm().format(date);
  }

  static DateTime stringToDate(String date) {
    DateTime result;
    try {
      result = DateTime.parse(date);
    } catch (error) {
      return null;
    }
    return result;
  }
}
