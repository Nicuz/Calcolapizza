import 'package:calcolapizza/app_localizations.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: CubertoBottomBar(
        barBorderRadius: BorderRadius.circular(10),
        inactiveIconColor: Colors.grey,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        initialSelection: 0,
        tabs: <TabData>[
          TabData(
            iconData: FontAwesomeIcons.calculator,
            title: "Calcolapizza",
            tabColor: Colors.deepOrange,
          ),
          TabData(
            iconData: FontAwesomeIcons.pizzaSlice,
            title: AppLocalizations.of(context).translate("savedDoughsTab"),
            tabColor: Colors.teal,
          ),
          TabData(
              iconData: FontAwesomeIcons.infoCircle,
              title: AppLocalizations.of(context).translate("aboutTab"),
              tabColor: Colors.amber),
        ],
        onTabChangedListener: (int position, String title, Color color) {
          navigationProvider.setPage = position;
        },
      ),
    );
  }
}
