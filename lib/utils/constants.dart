class AppConstants {
  static const String apiBaseUrl = 'http://localhost:8000';

  // API Endpoints
  static const String singlesPokemonEndpoint = '/api/products/singlesPokemon';
  static const String sealedPokemonEndpoint = '/api/products/sealedPokemon';
  static const String productDetailEndpoint = '/api/products/product_detail';
  static const String getOwnedProductsEndpoint = '/api/owned_products/get_owned_products';
  static const String addOwnedProductsEndpoint = '/api/owned_products/add_owned_products';

  // Page Routes
  static const String homeRoute = '/home';
  static const String singlesRoute = '/singles';
  static const String sealedRoute = '/sealed';
  static const String myCardsRoute = '/my-cards';
  static const String productDetailRoute = '/product-detail';
  static const String statisticsRoute = '/statistics';
  static const String notificationsRoute = '/notifications';
  static const String scrapingCenterRoute = '/scraping-center';
}
