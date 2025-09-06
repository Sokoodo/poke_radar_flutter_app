class SinglesDetail {
  final String idUrl;
  final String title;
  final String setName;
  final String image;
  final String language;
  final double currentMinPrice;
  final int currentAvailability;

  SinglesDetail({
    required this.idUrl,
    required this.title,
    required this.setName,
    required this.image,
    required this.language,
    required this.currentMinPrice,
    required this.currentAvailability,
  });

  factory SinglesDetail.fromJson(Map<String, dynamic> json) {
    return SinglesDetail(
      idUrl: json['id_url'] ?? '',
      title: json['title'] ?? '',
      setName: json['set_name'] ?? '',
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
      'set_name': setName,
      'image': image,
      'language': language,
      'current_min_price': currentMinPrice,
      'current_availability': currentAvailability,
    };
  }
}
