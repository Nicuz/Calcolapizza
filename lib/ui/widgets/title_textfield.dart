import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  final String title;
  final TextEditingController fieldValue;
  final String error;

  TitleTextField({this.title, this.fieldValue, this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        Card(
          elevation: 20,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              style: TextStyle(
                fontSize: 20.0,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                hintText: this.title,
              ),
              controller: this.fieldValue,
              validator: (String input) => input.trim().isEmpty ||
                      int.tryParse(input) == null ||
                      int.tryParse(input) < 0
                  ? this.error
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
