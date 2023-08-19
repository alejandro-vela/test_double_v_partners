import 'package:flutter/material.dart';

import '../characters/charactes.dart';
import '../episodes/episodes_screen.dart';
import '../locations/locations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4_rounded),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_sharp),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_rounded),
            label: 'Episodes',
          ),
        ],
      ),
      body: () {
        switch (_selectedIndex) {
          case 0:
            return const CharactersScreen();
          case 1:
            return const LocationsScreen();
          case 2:
            return const EpisodesScreen();
        }
      }(),
    );
  }
}
