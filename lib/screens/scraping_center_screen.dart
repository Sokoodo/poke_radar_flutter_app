import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_radar_app/screens/base_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScrapingCenterController extends GetxController {
  // TODO: Implementare logica per lo scraping center
  final RxBool loading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: Caricare dati scraping
  }
}

class ScrapingCenterScreen extends BaseScreen {
  const ScrapingCenterScreen({super.key});

  @override
  State<ScrapingCenterScreen> createState() => _ScrapingCenterScreenState();
}

class _ScrapingCenterScreenState extends BaseScreenState<ScrapingCenterScreen> {
  final ScrapingCenterController controller = Get.put(
    ScrapingCenterController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro Scraping'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ResponsiveBreakpoints.builder(
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.web_asset, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Centro Scraping',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Gestione dello scraping dati',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
