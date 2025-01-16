import 'package:cocktails_app/theme/colors.dart';
import 'package:flutter/material.dart';
import '../models/cocktail.dart';

class CocktailCard extends StatelessWidget {
  final Cocktail cocktail;
  final VoidCallback onTap;

  const CocktailCard({super.key, required this.cocktail, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: salmon,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(cocktail.imageUrl, fit: BoxFit.cover),
              ),
            ),
            // Nome del cocktail
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                cocktail.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
