import 'package:flutter/material.dart';

import '../model/themedata.dart';

class ThemeControler extends ChangeNotifier {
  Thame t = Thame(isDark: false);

  setDark() {
    t.isDark = !t.isDark;
    notifyListeners();
  }
}
