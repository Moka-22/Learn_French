import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class uiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  // Dark Mode
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );
  // Light Mode
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
  );

  // Dark Mode Toggle
  changeTheme() {
    _isDark = !isDark;
    // Save value 
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  // provider method
  init() async{
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark')??false;
    notifyListeners();
  }
}
