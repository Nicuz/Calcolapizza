import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: BubbleBottomBar(
        iconSize: 20,
        opacity: .2,
        currentIndex: navigationProvider.bottomBarIndex,
        onTap: (int index) {
          navigationProvider.setPage = index;
        },
        borderRadius: BorderRadius.circular(10),
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(
                FontAwesomeIcons.calculator,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.calculator,
                color: Colors.deepOrange,
              ),
              title: Text("Calcolapizza")),
          BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Icon(
                FontAwesomeIcons.pizzaSlice,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.pizzaSlice,
                color: Colors.teal,
              ),
              title: Text(
                  AppLocalizations.of(context).translate("savedDoughsTab"))),
          BubbleBottomBarItem(
              backgroundColor: Colors.amber,
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.amber,
              ),
              title: Text(AppLocalizations.of(context).translate("aboutTab"))),
        ],
      ),
    );
  }
}
