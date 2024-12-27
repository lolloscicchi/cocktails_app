import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: const HomePage(),
    ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Corretta dichiarazione della variabile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Contenuto della pagina: $_selectedIndex'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF55951),
        currentIndex: _selectedIndex,
        // Corretto l'accesso alla variabile
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Modifica dell'indice selezionato
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Preferiti',
          ),
        ],
      ),
    );
  }
}
