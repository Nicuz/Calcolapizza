import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/calcolapizza_provider.dart';
import 'package:calcolapizza/providers/dough_provider.dart';
import 'package:calcolapizza/providers/navigation_provider.dart';
import 'package:calcolapizza/ui/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(Calcolapizza());

class Calcolapizza extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => CalcolapizzaProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => DoughDetailsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Calcolapizza",
        theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
          color: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
        )),
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
      ),
    );
  }
}
