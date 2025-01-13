import 'dart:convert';

import 'package:cocktails_app/models/cocktail.dart';
import 'package:dio/dio.dart';
import '../models/cocktail.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Cocktail>> fetchCocktails() async {
    try {
      // URL del file su Google Drive
      const url = 'https://drive.google.com/uc?export=download&id=1YvertaR4lc01xOLv5woc4lLedFrCjtUX';

      // Effettua la richiesta GET
      final response = await _dio.get(url);

      // Verifica se la risposta è valida
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data) as List<dynamic>;
        return data.map((cocktail) => Cocktail.fromJson(cocktail)).toList();
      } else {
        throw Exception('Errore durante il caricamento dei dati: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}