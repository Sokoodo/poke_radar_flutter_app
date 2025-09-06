import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class NavigationService extends GetxService {
  static NavigationService get to => Get.find();

  void navigateToHome() {
    Get.offAllNamed(AppConstants.homeRoute);
  }

  void navigateToSingles() {
    Get.toNamed(AppConstants.singlesRoute);
  }

  void navigateToSealed() {
    Get.toNamed(AppConstants.sealedRoute);
  }

  void navigateToMyCards() {
    Get.toNamed(AppConstants.myCardsRoute);
  }

  void navigateToStatistics() {
    Get.toNamed(AppConstants.statisticsRoute);
  }

  void navigateToNotifications() {
    Get.toNamed(AppConstants.notificationsRoute);
  }

  void navigateToScrapingCenter() {
    Get.toNamed(AppConstants.scrapingCenterRoute);
  }

  void navigateToProductDetail(String idUrl) {
    Get.toNamed(AppConstants.productDetailRoute, parameters: {'id_url': idUrl});
  }

  Future<void> launchExternalUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
