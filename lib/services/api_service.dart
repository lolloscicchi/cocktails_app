import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/cocktail.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Cocktail>> fetchCocktails() async {
    try {
      const url = 'https://drive.google.com/uc?export=download&id=1YvertaR4lc01xOLv5woc4lLedFrCjtUX';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data) as List<dynamic>;
        if (kDebugMode) {
          print('Dati ricevuti: $data');
        }
        return data.map((cocktail) => Cocktail.fromJson(cocktail)).toList();
      } else {
        throw Exception('Errore durante il caricamento dei dati: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Errore durante la richiesta: $e');
      }
      throw Exception('Errore durante la richiesta: $e');
    }
  }
  Future<Cocktail> fetchCocktailDetails(String id) async {
    try {
      final url = 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> drinks = response.data['drinks'];
        if (kDebugMode) {
          print('Dettagli cocktail ricevuti: $drinks');
        }

        if (drinks.isNotEmpty) {
          return Cocktail.fromJson(drinks[0]);
        } else {
          throw Exception('Cocktail non trovato');
        }
      } else {
        throw Exception('Errore durante il caricamento dei dettagli: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Errore durante la richiesta: $e');
      }
      throw Exception('Errore durante la richiesta: $e');
    }
  }

}