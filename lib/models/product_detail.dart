import 'historical_scrape_data.dart';

class ProductDetail {
  final String idUrl;
  final String productName;
  final String title;
  final String? subtitle;
  final String image;
  final String productType;
  final String? setName;
  final String? cardNumber;
  final String language;
  final String? condition;
  final String tcgName;
  final String? pokemonSpecies;
  final double currentMinPrice;
  final int currentAvailability;
  final int ownedProductsCount;
  final List<HistoricalScrapeData> historicalScrapeData;

  ProductDetail({
    required this.idUrl,
    required this.productName,
    required this.title,
    this.subtitle,
    required this.image,
    required this.productType,
    this.setName,
    this.cardNumber,
    required this.language,
    this.condition,
    required this.tcgName,
    this.pokemonSpecies,
    required this.currentMinPrice,
    required this.currentAvailability,
    required this.ownedProductsCount,
    required this.historicalScrapeData,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    var historicalDataList = json['historical_scrape_data'] as List? ?? [];
    List<HistoricalScrapeData> historicalData = historicalDataList
        .map((data) => HistoricalScrapeData.fromJson(data))
        .toList();

    return ProductDetail(
      idUrl: json['id_url'] ?? '',
      productName: json['product_name'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      image: json['image'] ?? '',
      productType: json['product_type'] ?? '',
      setName: json['set_name'],
      cardNumber: json['card_number'],
      language: json['language'] ?? '',
      condition: json['condition'],
      tcgName: json['tcg_name'] ?? '',
      pokemonSpecies: json['pokemon_species'],
      currentMinPrice: (json['current_min_price'] ?? 0).toDouble(),
      currentAvailability: json['current_availability'] ?? 0,
      ownedProductsCount: json['owned_products_count'] ?? 0,
      historicalScrapeData: historicalData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_url': idUrl,
      'product_name': productName,
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'product_type': productType,
      'set_name': setName,
      'card_number': cardNumber,
      'language': language,
      'condition': condition,
      'tcg_name': tcgName,
      'pokemon_species': pokemonSpecies,
      'current_min_price': currentMinPrice,
      'current_availability': currentAvailability,
      'owned_products_count': ownedProductsCount,
      'historical_scrape_data': historicalScrapeData.map((e) => e.toJson()).toList(),
    };
  }
}
