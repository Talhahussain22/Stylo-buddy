import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:stylo_buddy/Views/Homepage.dart';
import 'package:stylo_buddy/Views/Outfits.dart';
import 'package:stylo_buddy/Views/Profile.dart';
import 'package:stylo_buddy/Views/Trend.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Generalpage extends StatefulWidget {
  Generalpage({super.key});

  @override
  State<Generalpage> createState() => _GeneralpageState();
}

class _GeneralpageState extends State<Generalpage> {
  int _currentIndex=0;

  List<Widget> _pages=[Homepage(),Outfits(),Trend(),Profile()];

  @override
  Widget build(BuildContext context) {
    final themeprovider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex,onTap: (index){
        _currentIndex=index;
        setState(() {

        });

      },
          selectedItemColor: Colors.pinkAccent,
          selectedLabelStyle: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold,fontSize: 10),

          unselectedItemColor: themeprovider.isDark?Colors.white70:  Colors.black54,
          unselectedLabelStyle: TextStyle(color:themeprovider.isDark?Colors.white70: Colors.black54,fontSize: 10),
          showUnselectedLabels: true,
          items: [
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house),label:"Homepage"),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.shirt),label:"Outfit"),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.arrowTrendUp),label:"Trend"),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.person),label:"Profile")
      ]));

  }}