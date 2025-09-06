import 'package:get/get.dart';
import 'package:poke_radar_app/screens/home_screen.dart';
import 'package:poke_radar_app/screens/my_cards_screen.dart';
import 'package:poke_radar_app/screens/notification_screen.dart';
import 'package:poke_radar_app/screens/product_detail_screen.dart';
import 'package:poke_radar_app/screens/scraping_center_screen.dart';
import 'package:poke_radar_app/screens/sealed_screen.dart';
import 'package:poke_radar_app/screens/singles_screen.dart';
import 'package:poke_radar_app/screens/statistics_screen.dart';
import '../services/navigation_service.dart';
import '../utils/constants.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: AppConstants.homeRoute, page: () => const HomeScreen()),
    GetPage(name: AppConstants.singlesRoute, page: () => const SinglesScreen()),
    GetPage(name: AppConstants.sealedRoute, page: () => const SealedScreen()),
    GetPage(name: AppConstants.myCardsRoute, page: () => const MyCardsScreen()),
    GetPage(
      name: AppConstants.productDetailRoute,
      page: () => const ProductDetailScreen(),
    ),
    GetPage(
      name: AppConstants.statisticsRoute,
      page: () => const StatisticsScreen(),
    ),
    GetPage(
      name: AppConstants.notificationsRoute,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: AppConstants.scrapingCenterRoute,
      page: () => const ScrapingCenterScreen(),
    ),
  ];

  static void initDependencies() {
    Get.put(NavigationService());
  }
}
