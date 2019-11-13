import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  MaterialColor _themeColor = Colors.red;

  MaterialColor get themeColor => _themeColor;

/*  MaterialColor _accentColor = Colors.red[50];

  MaterialColor get accentColor => _accentColor;*/

  void setTheme(MaterialColor themeColor) async {
    _themeColor = themeColor;
  //  _accentColor = themeColor[50];
    notifyListeners();
  }

  void setRandomTheme() async {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    _themeColor = Colors.primaries[colorIndex];
   // _accentColor = Colors.primaries[colorIndex][50];

    notifyListeners();
  }
}
