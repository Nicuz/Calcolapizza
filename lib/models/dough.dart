import 'dart:math';

import 'package:calcolapizza/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:calcolapizza/enums.dart';

extension on int {
  int celsius(TempUnit tempUnit) {
    return tempUnit == TempUnit.fahrenheit ? (this - 32) ~/ 1.8 : this;
  }
}

class Dough {
  int _id;
  String _doughName;
  int _doughsNumber;
  int _doughsWeight;
  int _totalDoughWeight;
  int _hydration;
  double _flour;
  double _water;
  double _salt;
  double _fats;
  double _yeast;
  int _roomTemp;
  int _risingTime;
  int _fridgeRisingTime;
  int _isGrandmaPizza;
  TempUnit tempUnit;

  Dough({
    @required int doughsNumber,
    @required int doughsWeight,
    @required int hydration,
    @required int saltPerLiter,
    @required int fatsPerLiter,
    @required int roomTemp,
    @required int risingTime,
    @required int fridgeRisingTime,
    @required bool isGrandmaPizza,
    @required TempUnit tempUnit,
  }) {
    _doughsNumber = doughsNumber;
    _doughsWeight = doughsWeight;
    _totalDoughWeight = doughsNumber * doughsWeight;
    _roomTemp = roomTemp;
    _risingTime = risingTime;
    _fridgeRisingTime = fridgeRisingTime;
    _isGrandmaPizza = isGrandmaPizza == true ? 1 : 0;

    double c = risingTime - 9 * fridgeRisingTime / 10;
    double C = (hydration * (saltPerLiter + fatsPerLiter) +
            pow(10, 3) * (hydration + 100))
        .toDouble();

    double n;
    if (isGrandmaPizza) {
      n = roomTemp.celsius(tempUnit) * (1 - 0.25 * 1);
    } else {
      n = roomTemp.celsius(tempUnit) * (1 - 0.25 * 0);
    }

    double h = 2250 *
        (1 + saltPerLiter / 200) *
        (1 + fatsPerLiter / 300) /
        ((4.2 * hydration - 80 - 0.0305 * hydration * hydration) *
            pow(n, 2.5) *
            pow(c, 1.2));

    _hydration = hydration;
    _flour = pow(10, 5) * _totalDoughWeight / C;
    _water = (pow(10, 3) * hydration * _totalDoughWeight) / C;
    _salt = (saltPerLiter * hydration * _totalDoughWeight) / C;
    _fats = (fatsPerLiter * hydration * _totalDoughWeight) / C;
    _yeast = _flour * h;
  }

  Dough.fromMap(Map<String, dynamic> map) {
    _id = map["ID"];
    _doughName = map["NAME"];
    _doughsNumber = map["DOUGHS_NUMBER"];
    _doughsWeight = map["DOUGHS_WEIGHT"];
    _hydration = map["HYDRATION"];
    _flour = map["FLOUR"].toDouble();
    _water = map["WATER"].toDouble();
    _salt = map["SALT"].toDouble();
    _fats = map["FATS"].toDouble();
    _yeast = map["YEAST"];
    _roomTemp = map["ROOM_TEMP"];
    _risingTime = map["RISING_TIME"];
    _fridgeRisingTime = map["FRIDGE_RISING_TIME"];
    _isGrandmaPizza = map["IS_GRANDMA_PIZZA"];
  }
  String get doughName => _doughName;
  int get doughsNumber => _doughsNumber;
  int get doughsWeight => _doughsWeight;
  int get fats => _fats.round();
  int get flour => _flour.round();
  int get fridgeRisingTime => _fridgeRisingTime;
  int get hydration => _hydration;
  int get id => _id;
  int get isGrandmaPizza => _isGrandmaPizza;
  int get risingTime => _risingTime;
  int get roomTemp => _roomTemp;
  int get salt => _salt.round();
  set setDoughName(String name) => _doughName = name;
  int get water => _water.round();
  double get yeast => num.parse(_yeast.toStringAsFixed(2));

  String shareString(BuildContext context) {
    final String _doughDescription = doughsNumber == 1
        ? "$doughsNumber ${AppLocalizations.of(context).translate("doughBallSingular")} (${doughsWeight}g), $hydration% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}"
        : "$doughsNumber ${AppLocalizations.of(context).translate("doughBallPlural")} (${doughsWeight}g), $hydration% ${AppLocalizations.of(context).translate("doughHydration").toLowerCase()}";

    final String _grandmaPizzaString = isGrandmaPizza == true
        ? "${AppLocalizations.of(context).translate("yes")}"
        : "${AppLocalizations.of(context).translate("no")}";

    return "$doughName\n\n" +
        "$_doughDescription\n\n" +
        "${AppLocalizations.of(context).translate("flour")}: ${flour}g\n" +
        "${AppLocalizations.of(context).translate("water")}: ${water}g\n" +
        "${AppLocalizations.of(context).translate("saltPerLiter")}: ${salt}g\n" +
        "${AppLocalizations.of(context).translate("fatsPerLiter")}: ${fats}g\n" +
        "${AppLocalizations.of(context).translate("yeast")}: ${yeast}g (${AppLocalizations.of(context).translate("fresh")}) / ${(yeast / 3).toStringAsFixed(2)}g (${AppLocalizations.of(context).translate("dry")})\n" +
        "${AppLocalizations.of(context).translate("risingTime")}: ${risingTime}h\n" +
        "${AppLocalizations.of(context).translate("roomTemperature")}: $roomTemp°C\n" +
        "${AppLocalizations.of(context).translate("fridgeRisingTime")}: ${fridgeRisingTime}h\n" +
        "${AppLocalizations.of(context).translate("grandmaPizza")}: $_grandmaPizzaString";
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map["NAME"] = doughName;
    map["DOUGHS_NUMBER"] = doughsNumber;
    map["DOUGHS_WEIGHT"] = doughsWeight;
    map["HYDRATION"] = hydration;
    map["FLOUR"] = flour;
    map["WATER"] = water;
    map["SALT"] = salt;
    map["FATS"] = fats;
    map["YEAST"] = yeast;
    map["ROOM_TEMP"] = roomTemp;
    map["RISING_TIME"] = risingTime;
    map["FRIDGE_RISING_TIME"] = fridgeRisingTime;
    map["IS_GRANDMA_PIZZA"] = isGrandmaPizza;

    return map;
  }
}
