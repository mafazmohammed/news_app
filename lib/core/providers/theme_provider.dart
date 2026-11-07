import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void switchMode(ThemeMode newMode){
    if(themeMode == newMode) return;
    themeMode = newMode;
    notifyListeners();

  }
}