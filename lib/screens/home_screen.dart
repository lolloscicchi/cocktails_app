import 'package:cocktails_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ExploreScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: salmon,
        selectedItemColor: Colors.white,
        selectedFontSize: 18,
        unselectedFontSize: 15,
        unselectedItemColor: Color(0xFF003366),
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_bar,
            ),
            label: 'Esplora',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Preferiti',

          ),
        ],
      ),
    );
  }
}
