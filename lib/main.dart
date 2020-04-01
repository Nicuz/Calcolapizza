import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/calcolapizza_provider.dart';
import 'package:calcolapizza/providers/dough_provider.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:calcolapizza/providers/settings_provider.dart';
import 'package:calcolapizza/ui/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("settings");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CalcolapizzaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoughDetailsProvider(),
        ),
      ],
      child: Calcolapizza(),
    ),
  );
}

class Calcolapizza extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ValueListenableBuilder(
      valueListenable: Hive.box("settings").listenable(keys: ["darkMode"]),
      builder: (BuildContext context, Box box, _) {
        SettingsProvider settingsProvider = SettingsProvider();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Calcolapizza",
          theme: settingsProvider.getTheme(box),
          home: Homepage(),
          supportedLocales: [
            Locale("en", "US"),
            Locale("it", "IT"),
            Locale("pt", "PT"),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              debugPrint("Locale is null.");
              return supportedLocales.first;
            }
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );
  }
}
