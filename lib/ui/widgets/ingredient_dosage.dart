import 'package:flutter/material.dart';

class IngredientDosage extends StatelessWidget {
  final String title;
  final String data;

  IngredientDosage({this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text("$data"),
      ],
    );
  }
}
