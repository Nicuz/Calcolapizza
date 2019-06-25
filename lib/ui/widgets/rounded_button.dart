import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final Function onPressed;

  RoundedButton(
      {this.text,
      this.color,
      this.textColor = Colors.white,
      this.borderRadius = 100,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: this.color,
      child: Text(
        this.text,
        style: TextStyle(
          color: this.textColor,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.borderRadius)),
      onPressed: this.onPressed,
    );
  }
}
