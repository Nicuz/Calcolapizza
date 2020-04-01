import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/calcolapizza_provider.dart';
import 'package:calcolapizza/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context).translate("settingsTitle"),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(AppLocalizations.of(context).translate("darkMode")),
                      ValueListenableBuilder(
                        valueListenable: Hive.box("settings")
                            .listenable(keys: ["fahrenheitMode"]),
                        builder: (BuildContext context, Box box, _) {
                          SettingsProvider settingsProvider =
                              SettingsProvider();
                          return Switch(
                            value: settingsProvider.getDarkModeStatus(box),
                            activeColor: Theme.of(context).accentColor,
                            onChanged: (bool isDark) {
                              settingsProvider.setTheme(box, isDark);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(AppLocalizations.of(context)
                          .translate("useFahrenheit")),
                      ValueListenableBuilder(
                        valueListenable: Hive.box("settings").listenable(),
                        builder: (BuildContext context, Box box, _) {
                          SettingsProvider settingsProvider =
                              SettingsProvider();
                          return Switch(
                            value: settingsProvider.getTempMode(box),
                            activeColor: Theme.of(context).accentColor,
                            onChanged: (bool isFahrenheit) {
                              final CalcolapizzaProvider calcolapizzaProvider =
                                  Provider.of<CalcolapizzaProvider>(context,
                                      listen: false);
                              calcolapizzaProvider
                                  .setTemperatures(isFahrenheit);
                              settingsProvider.switchTempUnit(
                                  box, isFahrenheit);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
