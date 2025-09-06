class SealedDetail {
  final String idUrl;
  final String title;
  final String image;
  final String language;
  final double currentMinPrice;
  final int currentAvailability;

  SealedDetail({
    required this.idUrl,
    required this.title,
    required this.image,
    required this.language,
    required this.currentMinPrice,
    required this.currentAvailability,
  });

  factory SealedDetail.fromJson(Map<String, dynamic> json) {
    return SealedDetail(
      idUrl: json['id_url'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      language: json['language'] ?? '',
      currentMinPrice: (json['current_min_price'] ?? 0).toDouble(),
      currentAvailability: json['current_availability'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_url': idUrl,
      'title': title,
      'image': image,
      'language': language,
      'current_min_price': currentMinPrice,
      'current_availability': currentAvailability,
    };
  }
}
