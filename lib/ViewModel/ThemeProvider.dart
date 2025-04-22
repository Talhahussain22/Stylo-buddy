import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier
{
  bool _isdark=false;

  ThemeProvider(){
    _loadtheme();
  }

  bool get isDark =>_isdark;

  ThemeData get currentTheme =>_isdark ? ThemeData.dark():ThemeData.light();

  void toggletheme() async
  {
    _isdark=!_isdark;
    SharedPreferences pref=await SharedPreferences.getInstance();
    await pref.setBool('isdark', _isdark);
    notifyListeners();
  }



  Future<void> _loadtheme() async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    _isdark=await pref.getBool('isdark')?? false;
    notifyListeners();
  }
}