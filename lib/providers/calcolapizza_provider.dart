import 'package:flutter/material.dart';

class CalcolapizzaProvider with ChangeNotifier {
  int _selectedHydration = 65;
  double _minRoomTemp = 15;
  double _maxRoomTemp = 35;
  int _selectedRoomTemp = 20;
  String _tempUnit = "°C";
  int _selectedRaisingTime = 24;
  int _selectedFridgeTime = 0;
  int _maxFridgeTime = 23;
  bool _isGrandmaPizza = false;
  final TextEditingController _doughNumber = TextEditingController(text: "1");
  final TextEditingController _doughWeight = TextEditingController(text: "200");
  int _saltPerLiter = 50;
  int _fatsPerLiter = 0;
  bool isCalculating = false;

  TextEditingController get doughNumber => _doughNumber;
  TextEditingController get doughWeight => _doughWeight;
  int get fatsPerLiter => _fatsPerLiter;
  bool get isGrandmaPizza => _isGrandmaPizza;
  int get maxFridgeTime => _maxFridgeTime;
  int get saltPerLiter => _saltPerLiter;
  int get selectedFridgeTime => _selectedFridgeTime;
  int get selectedHydration => _selectedHydration;
  int get selectedRaisingTime => _selectedRaisingTime;
  int get selectedRoomTemp => _selectedRoomTemp;
  double get minRoomTemp => _minRoomTemp;
  double get maxRoomTemp => _maxRoomTemp;
  String get tempUnit => _tempUnit;

  set setTempUnit(String unit) {
    _tempUnit = unit;
  }

  set setMinRoomTemp(double value) {
    _minRoomTemp = value;
  }

  set setMaxRoomTemp(double value) {
    _maxRoomTemp = value;
  }

  void setTemperatures(bool isFahrenheit) {
    if (isFahrenheit) {
      setMinRoomTemp = 59;
      setMaxRoomTemp = 95;
      setSelectedRoomTemp(68, shouldNotify: false);
      setTempUnit = "°F";
    } else {
      setMinRoomTemp = 15;
      setMaxRoomTemp = 35;
      setSelectedRoomTemp(20, shouldNotify: false);
      setTempUnit = "°C";
    }
  }

  set setIsGrandmaPizza(bool value) {
    _isGrandmaPizza = value;
    notifyListeners();
  }

  set setMaxFridgeTime(int value) {
    _maxFridgeTime = value;
  }

  void setSelectedFatsPerLiter(double value, {bool shouldNotify = true}) {
    _fatsPerLiter = value.toInt();
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setSelectedFridgeTime(double value, {bool shouldNotify = true}) {
    _selectedFridgeTime = value.toInt();
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setSelectedHydration(double value, {bool shouldNotify = true}) {
    _selectedHydration = value.toInt();
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setSelectedRisingTime(double value, {bool shouldNotify = true}) {
    _selectedRaisingTime = value.toInt();
    if (_selectedFridgeTime > _selectedRaisingTime - 1) {
      setSelectedFridgeTime(0, shouldNotify: false);
    }
    setMaxFridgeTime = _selectedRaisingTime - 1;

    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setSelectedRoomTemp(double value, {bool shouldNotify = true}) {
    _selectedRoomTemp = value.toInt();
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setSelectedSaltPerLiter(double value, {bool shouldNotify = true}) {
    _saltPerLiter = value.toInt();
    if (shouldNotify) {
      notifyListeners();
    }
  }
}
