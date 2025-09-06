import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import '../providers/category_provider.dart';
import '../widgets/card_grid.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    // Carica le carte quando lo screen viene inizializzato
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider = Provider.of<CategoryProvider>(
        context,
        listen: false,
      );
      final cardProvider = Provider.of<CardProvider>(context, listen: false);

      if (categoryProvider.activeCategory.isNotEmpty) {
        cardProvider.loadCardsByCategory(categoryProvider.activeCategory);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, CardProvider>(
      builder: (ctx, categoryProvider, cardProvider, _) {
        // Quando cambia la categoria attiva, carica le nuove carte
        if (categoryProvider.activeCategory.isNotEmpty &&
            cardProvider.cards.isEmpty &&
            !cardProvider.isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cardProvider.loadCardsByCategory(categoryProvider.activeCategory);
          });
        }

        if (categoryProvider.activeCategory.isEmpty) {
          return Center(
            child: Text(
              'Seleziona una categoria per visualizzare le carte',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        if (cardProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (cardProvider.error.isNotEmpty) {
          return Center(
            child: Text(
              'Errore: ${cardProvider.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (cardProvider.cards.isEmpty) {
          return Center(
            child: Text(
              'Nessuna carta trovata nella categoria ${categoryProvider.activeCategory}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return CardGrid(cards: cardProvider.cards);
      },
    );
  }
}
