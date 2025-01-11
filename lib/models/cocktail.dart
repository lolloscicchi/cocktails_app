class Cocktail {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final bool isAlcoholic;
  final String strInstructions;
  final String? strInstructionsIT;

  Cocktail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.isAlcoholic,
    required this.strInstructions,
    this.strInstructionsIT,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      imageUrl: json['strDrinkThumb'],
      category: json['strCategory'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      strInstructions: json['strInstructions'],
      strInstructionsIT: json['strInstructionsIT'],
    );
  }

  factory Cocktail.placeholder(int id) {
    return Cocktail(
      id: id.toString(),
      name: 'Cocktail $id',
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Category ${id % 3 + 1}',
      isAlcoholic: id % 2 == 0,
      strInstructions: 'Istruzioni per preparare il cocktail $id.',
      strInstructionsIT: id % 2 == 0 ? 'Istruzioni in italiano per il cocktail $id.' : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDrink': id,
      'strDrink': name,
      'strDrinkThumb': imageUrl,
      'strCategory': category,
      'strAlcoholic': isAlcoholic ? 'Alcoholic' : 'Non alcoholic',
      'strInstructions': strInstructions,
      'strInstructionsIT': strInstructionsIT,
    };
  }
}