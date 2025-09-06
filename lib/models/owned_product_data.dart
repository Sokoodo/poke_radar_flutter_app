class OwnedProductData {
  final String idUrl;
  final String title;
  final String image;
  final String setName;
  final String language;
  final double currentMinPrice;
  final int currentAvailability;
  final bool inMyCollection;
  final int ownedEntriesNumber;

  OwnedProductData({
    required this.idUrl,
    required this.title,
    required this.image,
    required this.setName,
    required this.language,
    required this.currentMinPrice,
    required this.currentAvailability,
    required this.inMyCollection,
    required this.ownedEntriesNumber,
  });

  factory OwnedProductData.fromJson(Map<String, dynamic> json) {
    return OwnedProductData(
      idUrl: json['id_url'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      setName: json['set_name'] ?? '',
      language: json['language'] ?? '',
      currentMinPrice: (json['current_min_price'] ?? 0).toDouble(),
      currentAvailability: json['current_availability'] ?? 0,
      inMyCollection: json['in_my_collection'] ?? false,
      ownedEntriesNumber: json['owned_entries_number'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_url': idUrl,
      'title': title,
      'image': image,
      'set_name': setName,
      'language': language,
      'current_min_price': currentMinPrice,
      'current_availability': currentAvailability,
      'in_my_collection': inMyCollection,
      'owned_entries_number': ownedEntriesNumber,
    };
  }
}
