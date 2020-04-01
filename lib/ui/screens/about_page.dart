import 'package:calcolapizza/app_localizations.dart';
import 'package:calcolapizza/providers/about_provider.dart';
import 'package:calcolapizza/ui/widgets/about_tile.dart';
import 'package:calcolapizza/ui/widgets/launch_url.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/app_icon.png',
                  width: 120,
                ),
                SizedBox(height: 10),
                Text(
                  "Calcolapizza",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).textTheme.body1.color),
                      text:
                          "${AppLocalizations.of(context).translate("aboutTabDescription1")} ",
                      children: <TextSpan>[
                        TextSpan(
                          text: "La Confraternita della Pizza",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AboutProvider.openURL(
                                  'https://www.laconfraternitadellapizza.net/');
                            },
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                            text:
                                " ${AppLocalizations.of(context).translate("aboutTabDescription2")}."),
                        TextSpan(
                            text:
                                "\n\n${AppLocalizations.of(context).translate("aboutTabDescription3")} "),
                        TextSpan(
                          text: AppLocalizations.of(context)
                              .translate("privacyPolicy"),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AboutProvider.openURL(
                                  'https://github.com/Nicuz/Calcolapizza/blob/master/privacy_policy.md');
                            },
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(text: "."),
                      ]),
                ),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate("appInfo"),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Divider(),
                    AboutTile(
                      icon: Icon(FontAwesomeIcons.history),
                      title: AppLocalizations.of(context).translate("version"),
                      subtitle: FutureBuilder(
                          future: AboutProvider.getAppVersion(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return Text("${snapshot.data}");
                          }),
                    ),
                    SizedBox(height: 20),
                    AboutTile(
                      icon: Icon(FontAwesomeIcons.solidUserCircle),
                      title: AppLocalizations.of(context).translate("author"),
                      subtitle: Text("Domenico Majorana"),
                    ),
                    SizedBox(height: 20),
                    AboutTile(
                      icon: Icon(FontAwesomeIcons.solidEnvelope),
                      title:
                          AppLocalizations.of(context).translate("contactMe"),
                      subtitle: LaunchURL(
                        text: "nico.majorana@gmail.com",
                        textStyle: TextStyle(
                            color: Theme.of(context).textTheme.body1.color),
                        url:
                            "mailto:nico.majorana@gmail.com?subject=Calcolapizza%20Form",
                      ),
                    ),
                    SizedBox(height: 20),
                    AboutTile(
                      icon: Icon(FontAwesomeIcons.github),
                      title: "GitHub",
                      subtitle: LaunchURL(
                        text: "@Nicuz",
                        textStyle: TextStyle(
                            color: Theme.of(context).textTheme.body1.color),
                        url: "https://github.com/Nicuz",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
