import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/cocktail.dart';
import '../services/api_service.dart';
import '../services/favorites_service.dart';
import '../theme/colors.dart';

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
    _cocktailFuture = _apiService
        .fetchCocktailDetails(widget.cocktailId); // Recupera i dettagli
  }

  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              'The Velvet Stir',
              style: GoogleFonts.islandMoments(
                color: white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      body: FutureBuilder<Cocktail>(
        future: _cocktailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Mostra il caricamento
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Errore: ${snapshot.error}')); // Mostra l'errore
          } else if (!snapshot.hasData) {
            return Center(child: Text('Nessun dato trovato.')); // Nessun dato
          } else {
            final cocktail = snapshot.data!;
            _isFavorite =
                favoritesService.favorites.any((c) => c.id == cocktail.id);

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Allinea gli elementi agli estremi
                    children: [
                      // Nome del cocktail
                      Text(
                        cocktail.name,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          if (_isFavorite) {
                            await favoritesService.removeFavorite(cocktail);
                          } else {
                            await favoritesService.addFavorite(cocktail);
                          }
                          setState(() {
                            _isFavorite =
                            !_isFavorite; // Aggiorna lo stato del preferito
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),

                      // Icona del cuore
                    ],
                  )),
                  // Immagine del cocktail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      cocktail.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Nome del cocktail
                  
                  SizedBox(height: 8),

                  // Categoria e tipo (alcolico/analcolico)
                  Row(
                    children: [
                      Icon(Icons.local_bar, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        cocktail.category,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Spacer(),
                      Icon(
                        cocktail.isAlcoholic
                            ? Icons.local_drink
                            : Icons.local_cafe,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        cocktail.isAlcoholic ? 'Alcolico' : 'Analcolico',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Ingredienti
                  Text(
                    'Ingredienti:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 8),
                  ..._buildIngredientsList(cocktail), // Mostra gli ingredienti
                  SizedBox(height: 16),

                  // Istruzioni
                  Text(
                    'Istruzioni:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    cocktail.strInstructionsIT ??
                        cocktail.strInstructions ??
                        'Nessuna istruzione disponibile.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),

                  // Bottone per aggiungere/rimuovere dai preferiti
                  Center(),
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
