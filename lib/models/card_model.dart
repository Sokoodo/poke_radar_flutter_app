class PokemonCard {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final double price;
  final String set;
  final String number;
  final String rarity;
  final bool owned;

  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.set,
    required this.number,
    required this.rarity,
    required this.owned,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      price: json['price']?.toDouble() ?? 0.0,
      set: json['set'],
      number: json['number'],
      rarity: json['rarity'],
      owned: json['owned'] ?? false,
    );
  }
}

class PriceHistory {
  final DateTime date;
  final double price;

  PriceHistory({required this.date, required this.price});

  factory PriceHistory.fromJson(Map<String, dynamic> json) {
    return PriceHistory(
      date: DateTime.parse(json['date']),
      price: json['price']?.toDouble() ?? 0.0,
    );
  }
}
