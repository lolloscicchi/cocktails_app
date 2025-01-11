import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cocktail.dart';
import '../services/api_service.dart';

class FavoritesService extends ChangeNotifier {
  static const String _favoritesKey = 'favorites';
  List<Cocktail> _favorites = [];

  List<Cocktail> get favorites => _favorites;

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

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(_favoritesKey) ?? [];
    final apiService = ApiService();
    _favorites = [];
    for (final id in favoriteIds) {
      final cocktail = await apiService.fetchCocktailDetails(id);
      _favorites.add(cocktail);
    }
    notifyListeners();
  }
}