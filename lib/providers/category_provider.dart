import 'package:flutter/foundation.dart';

class CategoryProvider with ChangeNotifier {
  // Lista delle categorie disponibili
  static const List<String> categories = ['Sealed', 'Singles', 'Owned'];

  // Stato delle categorie selezionate (inizialmente tutte deselezionate)
  List<bool> _selectedCategories = [false, false, false];

  // Categoria attualmente attiva
  String _activeCategory = '';

  List<bool> get selectedCategories => _selectedCategories;
  String get activeCategory => _activeCategory;

  // Metodo per attivare/dissattivare una categoria
  void toggleCategory(int index) {
    // Se la categoria è già selezionata, la deseleziona
    if (_selectedCategories[index]) {
      _selectedCategories[index] = false;
      _activeCategory = '';
    } else {
      // Deseleziona tutte le altre categorie
      for (int i = 0; i < _selectedCategories.length; i++) {
        _selectedCategories[i] = (i == index);
      }
      _activeCategory = categories[index];
    }
    notifyListeners();
  }

  // Metodo per selezionare una categoria specifica
  void selectCategory(String category) {
    final index = categories.indexOf(category);
    if (index != -1) {
      toggleCategory(index);
    }
  }

  // Metodo per deselezionare tutte le categorie
  void clearSelection() {
    for (int i = 0; i < _selectedCategories.length; i++) {
      _selectedCategories[i] = false;
    }
    _activeCategory = '';
    notifyListeners();
  }

  // Metodo per verificare se una categoria è attiva
  bool isCategoryActive(String category) {
    return _activeCategory == category;
  }
}
