import 'package:flutter/foundation.dart';
import '../models/card_model.dart';
import '../services/api_service.dart';

class CardProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<PokemonCard> _cards = [];
  PokemonCard? _selectedCard;
  List<PriceHistory> _priceHistory = [];
  bool _isLoading = false;
  String _error = '';

  List<PokemonCard> get cards => _cards;
  PokemonCard? get selectedCard => _selectedCard;
  List<PriceHistory> get priceHistory => _priceHistory;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadCardsByCategory(String category) async {
    if (category.isEmpty) {
      _cards = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _cards = await _apiService.getCardsByCategory(category.toLowerCase());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadCardDetail(String id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _selectedCard = await _apiService.getCardDetail(id);
      _priceHistory = await _apiService.getPriceHistory(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  void clearSelectedCard() {
    _selectedCard = null;
    _priceHistory = [];
    notifyListeners();
  }
}
