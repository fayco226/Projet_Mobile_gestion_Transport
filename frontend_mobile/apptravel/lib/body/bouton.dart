import 'dart:convert';
import 'package:apptravel/body/Apropos.dart';
import 'package:apptravel/body/Parcours.dart';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/body/pages.dart';
import 'package:apptravel/body/reserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:apptravel/body/recherche.dart';

class Boutonbar extends StatefulWidget {
  const Boutonbar({super.key});

  @override
  State<Boutonbar> createState() => _BoutonbarState();
}

class _BoutonbarState extends State<Boutonbar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Parcour(),
    Pages(),
    Propos(),
  ];
  void _tapesurbouton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _tapesurbouton,
          elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Color.fromARGB(255, 205, 163, 151),
          unselectedItemColor: const Color.fromARGB(255, 184, 197, 217),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
              ),
              label: 'Parcour',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.car_rental,
              ),
              label: 'Reservation',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info_rounded,
              ),
              label: 'Propos',
            ),
          ]),
    );
  }
}
