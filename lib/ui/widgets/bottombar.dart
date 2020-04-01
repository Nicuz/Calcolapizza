import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:calcolapizza/ui/theme.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);

    return Container(
      child: BubbleBottomBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        iconSize: 20,
        opacity: .2,
        currentIndex: navigationProvider.bottomBarIndex,
        onTap: (int index) {
          navigationProvider.setPage = index;
        },
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: AppTheme.bottombarActiveColor,
              icon: Icon(
                FontAwesomeIcons.calculator,
                color: AppTheme.bottombarInactiveColor,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.calculator,
                color: AppTheme.bottombarActiveColor,
              ),
              title: Text(
                "Calcolapizza",
                style: TextStyle(color: AppTheme.bottombarActiveColor),
              )),
          BubbleBottomBarItem(
              backgroundColor: AppTheme.bottombarActiveColor,
              icon: Icon(
                FontAwesomeIcons.pizzaSlice,
                color: AppTheme.bottombarInactiveColor,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.pizzaSlice,
                color: AppTheme.bottombarActiveColor,
              ),
              title: Text(
                AppLocalizations.of(context).translate("savedDoughsTab"),
                style: TextStyle(color: AppTheme.bottombarActiveColor),
              )),
        ],
      ),
    );
  }
}
