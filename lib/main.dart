import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importazione corretta
import 'data/cocktail_provider.dart';
import 'screens/home_screen.dart';
import 'services/favorites_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CocktailProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}