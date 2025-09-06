class MyProductDetail {
  final String productId;
  final int ownedQty;
  final double buyPrice;
  final String buyDate;
  final int buyAvailability;

  MyProductDetail({
    required this.productId,
    required this.ownedQty,
    required this.buyPrice,
    required this.buyDate,
    required this.buyAvailability,
  });

  factory MyProductDetail.fromJson(Map<String, dynamic> json) {
    return MyProductDetail(
      productId: json['product_id'] ?? '',
      ownedQty: json['owned_qty'] ?? 0,
      buyPrice: (json['buy_price'] ?? 0).toDouble(),
      buyDate: json['buy_date'] ?? '',
      buyAvailability: json['buy_availability'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'owned_qty': ownedQty,
      'buy_price': buyPrice,
      'buy_date': buyDate,
      'buy_availability': buyAvailability,
    };
  }
}
