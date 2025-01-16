import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cocktail.dart';

class FavoritesService extends ChangeNotifier {
  static const String _favoritesKey = 'favorites';
  List<Cocktail> _favorites = [];
  bool _isLoaded = false;

  List<Cocktail> get favorites => _favorites;
  bool get isLoaded => _isLoaded;

  Future<void> addFavorite(Cocktail cocktail) async {
    final prefs = await SharedPreferences.getInstance();
    _favorites.add(cocktail);
    await prefs.setStringList(_favoritesKey, _favorites.map((c) => c.id).toList());
    notifyListeners();
  }

  Future<void> removeFavorite(Cocktail cocktail) async {
    final prefs = await SharedPreferences.getInstance();
    _favorites.removeWhere((c) => c.id == cocktail.id);
    await prefs.setStringList(_favoritesKey, _favorites.map((c) => c.id).toList());
    notifyListeners();
  }

  Future<void> loadFavorites(BuildContext context) async {
    if (_isLoaded) return;
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(_favoritesKey) ?? [];

    _favorites = [];

    _isLoaded = true;
    notifyListeners();
  }
}