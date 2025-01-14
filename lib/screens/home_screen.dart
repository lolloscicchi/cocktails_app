import 'package:cocktails_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(
            child: Text(
              'The Velvet Stir',
              style: GoogleFonts.islandMoments(
                color: white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      backgroundColor: backgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: salmon,
        selectedItemColor: Colors.white,
        selectedFontSize: 18,
        unselectedFontSize: 15,
        unselectedItemColor: secondaryColorAlpha,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_bar,
              size: _selectedIndex == 0 ? 30 : 25,
            ),
            label: 'Esplora',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: _selectedIndex == 1 ? 30 : 25,
            ),
            label: 'Preferiti',
          ),
        ],
      ),
    );
  }
}
