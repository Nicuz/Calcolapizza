import 'package:calcolapizza/providers/calcolapizza_provider.dart';
import 'package:calcolapizza/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension on _TitleSliderState {
  void updateProviderValue(
      {@required CalcolapizzaProvider provider,
      @required double value,
      @required SliderType sliderType}) {
    switch (sliderType) {
      case SliderType.hydration:
        provider.setSelectedHydration(value, shouldNotify: false);
        break;
      case SliderType.salt:
        provider.setSelectedSaltPerLiter(value, shouldNotify: false);
        break;
      case SliderType.fats:
        provider.setSelectedFatsPerLiter(value, shouldNotify: false);
        break;
      case SliderType.roomTemp:
        provider.setSelectedRoomTemp(value, shouldNotify: false);
        break;
      case SliderType.risingTime:
        provider.setSelectedRisingTime(value, shouldNotify: false);
        break;
      case SliderType.fridgeRisingTime:
        provider.setSelectedFridgeTime(value, shouldNotify: false);
        break;
    }
  }
}

class TitleSlider extends StatefulWidget {
  @override
  _TitleSliderState createState() => _TitleSliderState();

  final String title;
  final String unit;
  double min;
  double max;
  int value;
  SliderType sliderType;
  final Function onChanged;

  TitleSlider({
    this.title,
    this.unit = "",
    @required this.min,
    @required this.max,
    @required this.value,
    this.sliderType,
    this.onChanged,
  });
}

class _TitleSliderState extends State<TitleSlider> {
  @override
  Widget build(BuildContext context) {
    final CalcolapizzaProvider calcolapizzaProvider =
        Provider.of<CalcolapizzaProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title),
        Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      widget.value.toString(),
                      style: TextStyle(fontSize: 40.0),
                    ),
                    Text(
                      widget.unit,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Slider(
                  min: widget.min,
                  max: widget.max,
                  value: widget.value.toDouble(),
                  onChanged: widget.onChanged,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (widget.value > widget.min) {
                          setState(() {
                            widget.value--;
                            //updateProviderValue(widget.value.toDouble());
                            updateProviderValue(
                              provider: calcolapizzaProvider,
                              value: widget.value.toDouble(),
                              sliderType: widget.sliderType,
                            );
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (widget.value < widget.max) {
                          setState(() {
                            widget.value++;
                            //updateProviderValue(widget.value.toDouble());
                            updateProviderValue(
                              provider: calcolapizzaProvider,
                              value: widget.value.toDouble(),
                              sliderType: widget.sliderType,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
