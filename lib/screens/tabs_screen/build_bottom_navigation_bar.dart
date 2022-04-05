import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(
    BuildContext context, Function onPress, int index, GlobalKey key) {
  return BottomNavigationBar(
      onTap: onPress,
      backgroundColor: Theme.of(context).primaryColor,
      selectedIconTheme: IconThemeData(color: Theme.of(context).splashColor),
      unselectedIconTheme: IconThemeData(color: Theme.of(context).dividerColor),
      selectedItemColor: Theme.of(context).splashColor,
      currentIndex: index,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context)
                .primaryColor, // this wouldn't need to be set when using the .fixed BottomNavigationBarType
            icon: const Icon(Icons.today),
            label: 'Overview'),
        BottomNavigationBarItem(
            icon: Container(
              child: Padding(
                child: Icon(Icons.gavel),
                padding: EdgeInsets.all(10),
              ),
              key: key,
            ),
            label: 'Short',
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            icon: const Icon(Icons.trending_up),
            label: 'Long',
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            icon: const Icon(Icons.schedule),
            label: 'Dreams',
            backgroundColor: Theme.of(context).primaryColor)
      ]);
}
