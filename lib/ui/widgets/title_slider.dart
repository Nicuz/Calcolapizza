import 'package:flutter/material.dart';

class TitleSlider extends StatelessWidget {
  final String title;
  final String unit;
  final double min;
  final double max;
  final int value;
  final Function onChanged;

  TitleSlider(
      {this.title,
      this.unit = "",
      this.min,
      this.max,
      this.value,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(this.title),
        Card(
          elevation: 15.0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      this.value.toString(),
                      style: TextStyle(fontSize: 40.0),
                    ),
                    Text(
                      this.unit,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Slider(
                  min: this.min,
                  max: this.max,
                  value: this.value.toDouble(),
                  onChanged: this.onChanged,
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.deepOrange[100],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
