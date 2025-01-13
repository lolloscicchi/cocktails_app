import 'package:flutter/cupertino.dart';

import '../models/cocktail.dart';
import '../services/api_service.dart';

class CocktailProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Cocktail> _cocktails = [];
  List<Cocktail> _filteredCocktails = [];
  String _searchQuery = '';
  String? _selectedCategory;
  bool? _isAlcoholic;
  bool _isLoading = false; // Stato di caricamento
  String? _errorMessage; // Messaggio di errore

  List<Cocktail> get cocktails => _cocktails;
  List<Cocktail> get filteredCocktails => _filteredCocktails;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  bool? get isAlcoholic => _isAlcoholic;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCocktails() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _cocktails = await _apiService.fetchCocktails();
      _filteredCocktails = _cocktails;
    } catch (e) {
      _errorMessage = 'Errore durante il caricamento dei cocktail: $e';
      print(_errorMessage); // Debug: stampa l'errore
    } finally {
      _isLoading = false;
      notifyListeners();
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