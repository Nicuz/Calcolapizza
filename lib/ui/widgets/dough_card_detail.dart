import 'package:flutter/material.dart';

class DoughCardDetail extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  DoughCardDetail({this.icon, this.iconColor, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          this.icon,
          color: iconColor,
        ),
        SizedBox(width: 20),
        Text(this.text),
      ],
    );
  }
}
