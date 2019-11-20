import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/config/manger.dart';
import 'package:news/entity/Content.dart';

class ThemeModel with ChangeNotifier {
  MaterialColor _themeColor = Colors.red;

  MaterialColor get themeColor => _themeColor;

  ThemeModel() {
    MaterialColor color = Colors.primaries[
        AppManger.sharedPreferences.getInt(Content.KEY_THEME_COLOR) ?? 0];
    setTheme(color);
  }

  void setTheme(MaterialColor themeColor) async {
    _themeColor = themeColor;
    notifyListeners();
  }

  void setRandomTheme() async {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    _themeColor = Colors.primaries[colorIndex];

    notifyListeners();
  }

  void saveThemeColor(MaterialColor color) async {
    var index = Colors.primaries.indexOf(color);

    AppManger.sharedPreferences.setInt(Content.KEY_THEME_COLOR, index);
  }
}
