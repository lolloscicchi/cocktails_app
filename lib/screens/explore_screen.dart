import 'package:cocktails_app/theme/colors.dart';
import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../services/api_service.dart';
import '../widgets/cocktail_card.dart';
import '../widgets/filter_panel.dart';
import '../widgets/search_bar.dart';
import 'detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ApiService _apiService = ApiService();
  List<Cocktail> _cocktails = [];
  List<Cocktail> _filteredCocktails = [];
  String _searchQuery = '';
  String? _selectedCategory;
  bool? _isAlcoholic;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCocktails();
  }

  Future<void> _loadCocktails() async {
    try {
      final cocktails =
          await _apiService.fetchCocktails(); // Effettua la chiamata API
      setState(() {
        _cocktails = cocktails;
        _filteredCocktails = cocktails;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Errore durante il caricamento dei cocktail: $e';
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredCocktails = _cocktails.where((cocktail) {
        final matchesSearch =
            cocktail.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesCategory =
            _selectedCategory == null || cocktail.category == _selectedCategory;
        final matchesAlcohol =
            _isAlcoholic == null || cocktail.isAlcoholic == _isAlcoholic;
        return matchesSearch && matchesCategory && matchesAlcohol;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MySearchBar(
                    onSearch: (query) {
                      setState(() {
                        _searchQuery = query;
                        _applyFilters();
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                // Spazio tra la barra di ricerca e il tasto dei filtri
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => FilterPanel(
                        categories:
                            _cocktails.map((c) => c.category).toSet().toList(),
                        onApplyFilters: (category, isAlcoholic) {
                          setState(() {
                            _selectedCategory = category;
                            _isAlcoholic = isAlcoholic;
                            _applyFilters();
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator()) // Mostra il caricamento
                : _errorMessage != null
                    ? Center(child: Text(_errorMessage!)) // Mostra l'errore
                    : _filteredCocktails.isEmpty
                        ? Center(
                            child: Text(
                                'Nessun risultato trovato.')) // Nessun dato
                        : GridView.builder(
                            padding: EdgeInsets.all(8),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: _filteredCocktails.length,
                            itemBuilder: (context, index) {
                              final cocktail = _filteredCocktails[index];
                              return CocktailCard(
                                cocktail: cocktail,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(cocktailId: cocktail.id),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
