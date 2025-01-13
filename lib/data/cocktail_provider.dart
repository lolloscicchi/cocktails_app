import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../services/api_service.dart';

class CocktailProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Cocktail> _cocktails = [];
  List<Cocktail> _filteredCocktails = [];
  String _searchQuery = '';
  String? _selectedCategory;
  bool? _isAlcoholic;

  List<Cocktail> get cocktails => _cocktails;
  List<Cocktail> get filteredCocktails => _filteredCocktails;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  bool? get isAlcoholic => _isAlcoholic;

  Future<void> loadCocktails() async {
    try {
      _cocktails = await _apiService.fetchCocktails();
      _filteredCocktails = _cocktails;
      notifyListeners();
    } catch (e) {
      print('Errore durante il caricamento dei cocktail: $e');
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setFilters(String? category, bool? isAlcoholic) {
    _selectedCategory = category;
    _isAlcoholic = isAlcoholic;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredCocktails = _cocktails.where((cocktail) {
      final matchesSearch = cocktail.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || cocktail.category == _selectedCategory;
      final matchesAlcohol = _isAlcoholic == null || cocktail.isAlcoholic == _isAlcoholic;
      return matchesSearch && matchesCategory && matchesAlcohol;
    }).toList();
    notifyListeners();
  }
}