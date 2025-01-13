import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cocktail.dart';
import '../services/api_service.dart';
import '../services/favorites_service.dart';

class DetailScreen extends StatefulWidget {
  final String cocktailId;

  const DetailScreen({required this.cocktailId, super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<Cocktail> _cocktailFuture;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _cocktailFuture = _apiService.fetchCocktailDetails(widget.cocktailId); // Recupera i dettagli
  }

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dettaglio Cocktail'),
      ),
      body: FutureBuilder<Cocktail>(
        future: _cocktailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Mostra il caricamento
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}')); // Mostra l'errore
          } else if (!snapshot.hasData) {
            return Center(child: Text('Nessun dato trovato.')); // Nessun dato
          } else {
            final cocktail = snapshot.data!;
            _isFavorite = favoritesService.favorites.any((c) => c.id == cocktail.id);

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(cocktail.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                  SizedBox(height: 16),
                  Text(cocktail.name, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 8),
                  Text('Categoria: ${cocktail.category}'),
                  SizedBox(height: 8),
                  Text(cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico'),
                  SizedBox(height: 16),
                  Text('Ingredienti:', style: Theme.of(context).textTheme.titleMedium),
                  ..._buildIngredientsList(cocktail), // Mostra gli ingredienti
                  SizedBox(height: 16),
                  Text('Istruzioni:', style: Theme.of(context).textTheme.titleMedium),
                  Text(cocktail.strInstructionsIT ?? cocktail.strInstructions ?? 'Nessuna istruzione disponibile.'),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_isFavorite) {
                          await favoritesService.removeFavorite(cocktail);
                        } else {
                          await favoritesService.addFavorite(cocktail);
                        }
                        setState(() {
                          _isFavorite = !_isFavorite; // Aggiorna lo stato del preferito
                        });
                      },
                      child: Text(
                        _isFavorite ? 'Rimuovi dai preferiti' : 'Aggiungi ai preferiti',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Metodo per costruire la lista degli ingredienti
  List<Widget> _buildIngredientsList(Cocktail cocktail) {
    final ingredients = <Widget>[];
    final ingredientFields = [
      cocktail.strIngredient1,
      cocktail.strIngredient2,
      cocktail.strIngredient3,
      cocktail.strIngredient4,
      cocktail.strIngredient5,
      cocktail.strIngredient6,
      cocktail.strIngredient7,
      cocktail.strIngredient8,
      cocktail.strIngredient9,
      cocktail.strIngredient10,
      cocktail.strIngredient11,
      cocktail.strIngredient12,
      cocktail.strIngredient13,
      cocktail.strIngredient14,
      cocktail.strIngredient15,
    ];

    for (final ingredient in ingredientFields) {
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(Text('- $ingredient'));
      }
    }

    return ingredients;
  }
}