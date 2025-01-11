import '../models/cocktail.dart';


class ApiService {
  Future<List<Cocktail>> fetchCocktails() async {
    await Future.delayed(Duration(seconds: 1)); // Simula un ritardo
    return List.generate(10, (index) => Cocktail.placeholder(index + 1));
  }

  Future<Cocktail> fetchCocktailDetails(String id) async {
    await Future.delayed(Duration(seconds: 1)); // Simula un ritardo
    return Cocktail.placeholder(int.parse(id));
  }
}