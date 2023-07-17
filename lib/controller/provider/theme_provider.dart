import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThmeModel thmeModel;

  ThemeProvider({
    required this.thmeModel,
  });

  changeTheme() async {
    thmeModel.isdark = !thmeModel.isdark;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isdark', thmeModel.isdark);

    notifyListeners();
  }
}
