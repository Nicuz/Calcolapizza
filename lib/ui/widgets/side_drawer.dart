import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:calcolapizza/ui/screens/about_page.dart';
import 'package:calcolapizza/ui/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider =
        Provider.of<NavigationProvider>(context);
    return Drawer(
      elevation: 0,
      child: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "Calcolapizza",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.calculator,
              ),
              title: Text(
                'Calcolapizza',
              ),
              onTap: () {
                navigationProvider.setPageFromDrawer = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.pizzaSlice,
              ),
              title: Text(
                  AppLocalizations.of(context).translate("savedDoughsTab")),
              onTap: () {
                navigationProvider.setPageFromDrawer = 1;
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.cog,
              ),
              title:
                  Text(AppLocalizations.of(context).translate("settingsTitle")),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.infoCircle,
              ),
              title: Text(AppLocalizations.of(context).translate("aboutTab")),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
