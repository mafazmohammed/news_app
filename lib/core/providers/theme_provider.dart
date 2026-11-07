import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  switchMode(ThemeMode newMode){
    if(themeMode == newMode) return;
    themeMode = newMode;
    notifyListeners();

  }
}