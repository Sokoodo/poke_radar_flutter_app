import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:poke_radar_app/screens/detail_screen.dart';
import '../models/card_model.dart';
import 'pokemon_card.dart';

class CardGrid extends StatelessWidget {
  final List<PokemonCard> cards;

  const CardGrid({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        crossAxisCount: _getCrossAxisCount(context),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: cards.length,
        itemBuilder: (ctx, index) {
          final card = cards[index];
          return PokemonCardWidget(
            card: card,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(cardId: card.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4; // Desktop large
    if (width > 800) return 3; // Desktop/tablet
    if (width > 600) return 2; // Tablet
    return 2; // Mobile
  }
}
