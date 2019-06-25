import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchURL extends StatelessWidget {
  final String text;
  final String url;
  final TextStyle textStyle;

  LaunchURL(
      {this.text,
      this.url,
      this.textStyle = const TextStyle(color: Colors.black)});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: this.text,
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            if (await canLaunch(this.url)) {
              await launch(this.url);
            } else {
              throw 'Could not launch $url';
            }
          },
        style: this.textStyle,
      ),
    );
  }
}
