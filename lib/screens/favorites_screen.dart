import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cocktail.dart';
import '../services/favorites_service.dart';
import '../widgets/cocktail_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferiti'),
      ),
      body: FutureBuilder<void>(
        future: favoritesService.loadFavorites(), // Carica i preferiti
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore nel caricamento dei preferiti.'));
          } else if (favoritesService.favorites.isEmpty) {
            return Center(child: Text('Nessun cocktail nei preferiti.'));
          } else {
            final favorites = favoritesService.favorites; // Usa la proprietà favorites
            return GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final cocktail = favorites[index];
                return CocktailCard(
                  cocktail: cocktail,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(cocktailId: cocktail.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}