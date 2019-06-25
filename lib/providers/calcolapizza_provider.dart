import 'package:flutter/material.dart';

class CalcolapizzaProvider with ChangeNotifier {
  int _selectedHydration = 65;
  int _selectedRoomTemp = 20;
  int _selectedRaisingTime = 24;
  int _selectedFridgeTime = 0;
  int _maxFridgeTime = 23;
  bool _isGrandmaPizza = false;
  final TextEditingController _doughNumber = TextEditingController(text: "1");
  final TextEditingController _doughWeight = TextEditingController(text: "200");
  int _saltPerLiter = 50;
  int _fatsPerLiter = 0;

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

  set setIsGrandmaPizza(bool value) {
    _isGrandmaPizza = value;
    notifyListeners();
  }

  set setMaxFridgeTime(int value) {
    _maxFridgeTime = value;
    notifyListeners();
  }

  set setSelectedFatsPerLiter(double value) {
    _fatsPerLiter = value.toInt();
    notifyListeners();
  }

  set setSelectedFridgeTime(double value) {
    _selectedFridgeTime = value.toInt();
    notifyListeners();
  }

  set setSelectedHydration(double value) {
    _selectedHydration = value.toInt();
    notifyListeners();
  }

  set setSelectedRaisingTime(double value) {
    _selectedRaisingTime = value.toInt();
    if (_selectedFridgeTime > _selectedRaisingTime - 1) {
      setSelectedFridgeTime = 0;
    }
    setMaxFridgeTime = _selectedRaisingTime - 1;
    notifyListeners();
  }

  set setSelectedRoomTemp(double value) {
    _selectedRoomTemp = value.toInt();
    notifyListeners();
  }

  set setSelectedSaltPerLiter(double value) {
    _saltPerLiter = value.toInt();
    notifyListeners();
  }
}
