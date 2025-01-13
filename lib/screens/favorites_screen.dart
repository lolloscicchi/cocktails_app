import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_service.dart';
import '../widgets/cocktail_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);

    // Se i preferiti sono già caricati, non avviare di nuovo il Future
    if (!favoritesService.isLoaded) {
      favoritesService.loadFavorites(this as BuildContext);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferiti'),
      ),
      body: favoritesService.isLoaded
          ? _buildContent(favoritesService)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildContent(FavoritesService favoritesService) {
    if (favoritesService.favorites.isEmpty) {
      return Center(child: Text('Nessun cocktail nei preferiti.'));
    }

    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: favoritesService.favorites.length,
      itemBuilder: (context, index) {
        final cocktail = favoritesService.favorites[index];
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
}