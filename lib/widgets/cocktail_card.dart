import 'package:flutter/material.dart';
import '../models/cocktail.dart';

class CocktailCard extends StatelessWidget {
  final Cocktail cocktail;
  final VoidCallback onTap;

  const CocktailCard({required this.cocktail, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Image.network(cocktail.imageUrl, height: 120, fit: BoxFit.cover),
            Text(cocktail.name),
          ],
        ),
      ),
    );
  }
}