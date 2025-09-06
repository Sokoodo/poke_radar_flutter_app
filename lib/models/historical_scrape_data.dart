class HistoricalScrapeData {
  final String scrapeDate;
  final double avgPrice;
  final double minPrice;
  final double maxPrice;
  final int detailedAvailability;
  final int totalAvailability;

  HistoricalScrapeData({
    required this.scrapeDate,
    required this.avgPrice,
    required this.minPrice,
    required this.maxPrice,
    required this.detailedAvailability,
    required this.totalAvailability,
  });

  factory HistoricalScrapeData.fromJson(Map<String, dynamic> json) {
    return HistoricalScrapeData(
      scrapeDate: json['scrape_date'] ?? '',
      avgPrice: (json['avg_price'] ?? 0).toDouble(),
      minPrice: (json['min_price'] ?? 0).toDouble(),
      maxPrice: (json['max_price'] ?? 0).toDouble(),
      detailedAvailability: json['detailed_availability'] ?? 0,
      totalAvailability: json['total_availability'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scrape_date': scrapeDate,
      'avg_price': avgPrice,
      'min_price': minPrice,
      'max_price': maxPrice,
      'detailed_availability': detailedAvailability,
      'total_availability': totalAvailability,
    };
  }
}
