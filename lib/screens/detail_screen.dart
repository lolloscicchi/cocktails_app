import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cocktail.dart';
import '../services/api_service.dart';
import '../services/favorites_service.dart';

class DetailScreen extends StatefulWidget {
  final String cocktailId;

  DetailScreen({required this.cocktailId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Cocktail> _cocktailFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _cocktailFuture = _apiService.fetchCocktailDetails(widget.cocktailId);
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore nel caricamento dei dettagli.'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Nessun dato trovato.'));
          } else {
            final cocktail = snapshot.data!;
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
                  ..._buildIngredientsList(cocktail),
                  SizedBox(height: 16),
                  Text('Istruzioni:', style: Theme.of(context).textTheme.titleMedium),
                  Text(cocktail.strInstructionsIT ?? cocktail.strInstructions),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (favoritesService.favorites.any((c) => c.id == cocktail.id)) {
                          await favoritesService.removeFavorite(cocktail);
                        } else {
                          await favoritesService.addFavorite(cocktail);
                        }
                      },
                      child: Text(
                        favoritesService.favorites.any((c) => c.id == cocktail.id)
                            ? 'Rimuovi dai preferiti'
                            : 'Aggiungi ai preferiti',
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

  List<Widget> _buildIngredientsList(Cocktail cocktail) {
    final ingredients = <Widget>[];
    for (var i = 1; i <= 15; i++) {
      final ingredient = cocktail.toJson()['strIngredient$i'];
      if (ingredient != null) {
        ingredients.add(Text('- $ingredient'));
      }
    }
    return ingredients;
  }
}