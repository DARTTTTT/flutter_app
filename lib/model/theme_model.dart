import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  MaterialColor _themeColor = Colors.red;

  MaterialColor get themeColor => _themeColor;


  void setTheme(MaterialColor themeColor) async {
    _themeColor = themeColor;
    notifyListeners();
  }

  void setRandomTheme() async {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    _themeColor = Colors.primaries[colorIndex];

    notifyListeners();
  }
}
