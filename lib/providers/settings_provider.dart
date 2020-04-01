import 'package:calcolapizza/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

extension on Box {
  bool getBool(String key) {
    if (this.get(key) != null) {
      return this.get(key);
    }

    this.put(key, false);
    return false;
  }
}

class SettingsProvider {
  bool getDarkModeStatus(Box box) {
    return box.getBool("darkMode");
  }

  ThemeData getTheme(Box box) {
    return getDarkModeStatus(box) ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  void setTheme(Box box, bool isDark) {
    box.put("darkMode", isDark);
  }

  bool getTempMode(Box box) {
    return box.getBool("fahrenheitMode");
  }

  void switchTempUnit(Box box, bool isFahrenheit) {
    box.put("fahrenheitMode", isFahrenheit);
  }
}
