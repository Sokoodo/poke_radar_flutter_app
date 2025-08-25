import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';

  Future<List<PokemonCard>> getCardsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/cards?category=$category'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => PokemonCard.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }
 
  Future<PokemonCard> getCardDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/cards/$id'));
    
    if (response.statusCode == 200) {
      return PokemonCard.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load card details');
    }
  }

  Future<List<PriceHistory>> getPriceHistory(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/cards/$id/price-history'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => PriceHistory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load price history');
    }
  }
}